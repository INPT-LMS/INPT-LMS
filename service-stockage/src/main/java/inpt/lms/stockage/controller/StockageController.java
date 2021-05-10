package inpt.lms.stockage.controller;

import java.io.File;
import java.io.IOException;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonView;

import inpt.lms.stockage.authorization.AuthorizationService;
import inpt.lms.stockage.business.interfaces.FichierEtInfo;
import inpt.lms.stockage.business.interfaces.GestionnaireFichier;
import inpt.lms.stockage.business.interfaces.exceptions.NotFoundException;
import inpt.lms.stockage.business.interfaces.exceptions.StorageLimitExceededException;
import inpt.lms.stockage.controller.exceptions.FileTooBigException;
import inpt.lms.stockage.controller.exceptions.UnauthorizedException;
import inpt.lms.stockage.forms.ParamAssocId;
import inpt.lms.stockage.model.AssociationFichier;
import inpt.lms.stockage.model.FichierInfo;
import inpt.lms.stockage.model.TypeAssociation;
import inpt.lms.stockage.proxies.ProxyUnavailableException;

@RestController
@RequestMapping(path = "/storage", produces = "application/json",
consumes = "application/json")
public class StockageController {
	@Value("${inpt.lms.stockage.max-size}")
	protected long maxSize;
	@Autowired
	protected GestionnaireFichier gestionnaireFichier;
	@Autowired
	protected AuthorizationService authService;
	
	private ResponseEntity<byte[]> lireFichier(Long assocId) 
			throws NotFoundException, IOException {
		FichierEtInfo fichier = gestionnaireFichier.lireFichier(assocId);
		FichierInfo info = fichier.getFichierInfo();
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION,
				"attachment; filename=\"" + info.getNom() + "\"")
				.header(HttpHeaders.CONTENT_TYPE, info.getContentType())
				.body(fichier.getFichierContenu());
	}
	
	@PostMapping("class/{coursId}/files")
	@JsonView(AssociationFichier.Public.class)
	public AssociationFichier ajoutFichierCours(@PathVariable String coursId,
			@RequestBody @Valid ParamAssocId assocId, 
			@RequestHeader(name = "X-USER-ID") long userId) throws NotFoundException, UnauthorizedException, ProxyUnavailableException{
		authService.isClassOwner(coursId, userId);
		return gestionnaireFichier.ajoutDansCours(coursId, assocId.getAssocId());
	}
	
	@PostMapping("user/files")
	@JsonView(AssociationFichier.Public.class)
	public AssociationFichier ajoutFichierSac(@RequestBody ParamAssocId assocId, 
			@RequestHeader(name = "X-USER-ID") long userId) throws NotFoundException{
		return gestionnaireFichier.ajoutDansSac(userId, assocId.getAssocId());
	}

	@DeleteMapping("class/{coursId}/files/{assocId}")
	public void retraitFichierCours(@PathVariable Long assocId,
			@PathVariable String coursId, @RequestHeader(name = "X-USER-ID") long userId)
					throws NotFoundException, UnauthorizedException, ProxyUnavailableException{
		authService.isClassOwner(coursId, userId);
		gestionnaireFichier.retraitCours(assocId);
	}
	
	@DeleteMapping("user/files/{assocId}")
	public void retraitFichierSac(@PathVariable Long assocId,
			@RequestHeader(name = "X-USER-ID") long userId) 
					throws NotFoundException, IOException{
		
		gestionnaireFichier.retraitSac(userId,assocId);
	}
	
	@GetMapping("user/files")
	public Page<AssociationFichier> listerFichiersSac(
			@RequestHeader(name = "X-USER-ID") long userId, Pageable pagination){
		return gestionnaireFichier.getListeFichiersAssocies(String.valueOf(userId), 
				TypeAssociation.SAC, pagination)
				.map(AssociationFichier::masquerProprietes);
	}
	
	@GetMapping("class/{coursId}/files")
	public Page<AssociationFichier> listerFichiersCours(@PathVariable String coursId,
			@RequestHeader(name = "X-USER-ID") long userId,Pageable pagination) 
					throws UnauthorizedException, ProxyUnavailableException{
		authService.isClassMemberOrOwner(coursId, userId);
		return gestionnaireFichier.getListeFichiersAssocies(coursId, 
				TypeAssociation.COURS, pagination)
				.map(AssociationFichier::masquerProprietes);
	}

	@GetMapping("class/{coursId}/files/{assocId}/info")
	@JsonView(AssociationFichier.Public.class)
	public AssociationFichier getInfoFichierCours(@PathVariable Long assocId,
			@PathVariable String coursId,@RequestHeader(name = "X-USER-ID") long userId)
					throws NotFoundException, UnauthorizedException, ProxyUnavailableException{
		authService.isClassMemberOrOwner(coursId, userId);
		return gestionnaireFichier.getFichierByAssocId(assocId);
	}
	
	@GetMapping("class/{coursId}/files/{assocId}")
	public ResponseEntity<byte[]> getFichierCours(@PathVariable Long assocId,
			@PathVariable String coursId,@RequestHeader(name = "X-USER-ID") long userId)
					throws NotFoundException, IOException, UnauthorizedException, ProxyUnavailableException{
		authService.isClassMemberOrOwner(coursId, userId);
		return lireFichier(assocId);
	}
	
	@GetMapping("user/files/{assocId}/info")
	@JsonView(AssociationFichier.Public.class)
	public AssociationFichier getInfoFichierSac(@PathVariable Long assocId,
			@RequestHeader(name = "X-USER-ID") long userId) throws NotFoundException{
		return gestionnaireFichier.getFichierByAssocId(assocId);
	}
	
	@GetMapping("user/files/{assocId}")
	public ResponseEntity<byte[]> getFichierSac(@PathVariable Long assocId,
			@PathVariable Long userId) throws NotFoundException, IOException{
		
		return lireFichier(assocId);
	}
	
	@PostMapping(path = "user/files", consumes = "multipart/form-data")
	public AssociationFichier uploadFichierSac(@RequestParam MultipartFile fichier,
			@RequestHeader(name = "X-USER-ID") long userId) throws IOException,
				StorageLimitExceededException, FileTooBigException{
		if (fichier.getSize() > maxSize)
			throw new FileTooBigException(maxSize);
		String filename = new File(fichier.getOriginalFilename()).getName();
		AssociationFichier assoc = gestionnaireFichier.uploadFichierSac(userId, 
				fichier.getBytes(),fichier.getContentType(),filename,fichier.getSize());
		return AssociationFichier.masquerProprietes(assoc);
	}
	
	@PostMapping("publication/{publicationId}/files")
	@JsonView(AssociationFichier.Public.class)
	public AssociationFichier ajoutFichierPublication(@PathVariable String publicationId,
			@RequestBody @Valid ParamAssocId assocId, 
			@RequestHeader(name = "X-USER-ID") long userId) throws NotFoundException, UnauthorizedException, ProxyUnavailableException{
		authService.isPublicationOwner(publicationId, userId);
		return gestionnaireFichier.ajoutDansPublication(publicationId, assocId.getAssocId());
	}
	
	@DeleteMapping("publication/{publicationId}/files/{assocId}")
	public void retraitFichierPublication(@PathVariable Long assocId,
			@PathVariable String publicationId, @RequestHeader(name = "X-USER-ID") long userId)
					throws NotFoundException, UnauthorizedException, ProxyUnavailableException{
		authService.isPublicationOwner(publicationId, userId);
		gestionnaireFichier.retraitPublication(assocId);
	}
	
	@GetMapping("publication/{publicationId}/files")
	public Page<AssociationFichier> listerFichiersPublication(@PathVariable String publicationId,
			@RequestHeader(name = "X-USER-ID") long userId,Pageable pagination) 
					throws UnauthorizedException, ProxyUnavailableException{
		authService.isPublicationClassMemberOrOwner(publicationId, userId);
		return gestionnaireFichier.getListeFichiersAssocies(publicationId, 
				TypeAssociation.PUBLICATION, pagination)
				.map(AssociationFichier::masquerProprietes);
	}
	
	@GetMapping("publication/{publicationId}/files/{assocId}/info")
	@JsonView(AssociationFichier.Public.class)
	public AssociationFichier getInfoFichierpublication(@PathVariable Long assocId,
			@PathVariable String publicationId,@RequestHeader(name = "X-USER-ID") long userId)
					throws NotFoundException, UnauthorizedException, ProxyUnavailableException{
		authService.isPublicationClassMemberOrOwner(publicationId, userId);
		return gestionnaireFichier.getFichierByAssocId(assocId);
	}
	
	@GetMapping("publication/{publicationId}/files/{assocId}")
	public ResponseEntity<byte[]> getFichierpublication(@PathVariable Long assocId,
			@PathVariable String publicationId,@RequestHeader(name = "X-USER-ID") long userId)
					throws NotFoundException, IOException, UnauthorizedException, ProxyUnavailableException{
		authService.isPublicationClassMemberOrOwner(publicationId, userId);
		return lireFichier(assocId);
	}

	public long getMaxSize() {
		return maxSize;
	}

	public void setMaxSize(long maxSize) {
		this.maxSize = maxSize;
	}

	public GestionnaireFichier getGestionnaireFichier() {
		return gestionnaireFichier;
	}

	public void setGestionnaireFichier(GestionnaireFichier gestionnaireFichier) {
		this.gestionnaireFichier = gestionnaireFichier;
	}
}
