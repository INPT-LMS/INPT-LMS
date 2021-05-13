package inpt.lms.stockage.controller;

import java.io.IOException;
import java.util.UUID;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.annotation.JsonView;

import inpt.lms.stockage.authorization.AuthorizationService;
import inpt.lms.stockage.business.interfaces.GestionnaireFichier;
import inpt.lms.stockage.business.interfaces.exceptions.NotFoundException;
import inpt.lms.stockage.controller.exceptions.UnauthorizedException;
import inpt.lms.stockage.forms.ParamAssocId;
import inpt.lms.stockage.model.AssociationFichier;
import inpt.lms.stockage.model.TypeAssociation;
import inpt.lms.stockage.proxies.ProxyUnavailableException;
import inpt.lms.stockage.util.ControllerResponseUtils;

@RestController
@RequestMapping(path = "/storage/class", produces = "application/json",
consumes = "application/json")
public class ClassStockageController {
	@Value("${inpt.lms.stockage.max-size}")
	protected long maxSize;
	@Autowired
	protected GestionnaireFichier gestionnaireFichier;
	@Autowired
	protected AuthorizationService authService;
	
	private UUID getCoursUUID(String coursId) throws NotFoundException{
		try {
			return UUID.fromString(coursId);
		} catch (IllegalArgumentException e) {
			throw new NotFoundException("course");
		}
	}
	
	@PostMapping("{coursId}/files")
	@JsonView(AssociationFichier.Public.class)
	public AssociationFichier ajoutFichierCours(@PathVariable String coursId,
			@RequestBody @Valid ParamAssocId assocId, 
			@RequestHeader(name = "X-USER-ID") long userId) throws NotFoundException, UnauthorizedException, ProxyUnavailableException{
		authService.isClassOwner(getCoursUUID(coursId), userId);
		gestionnaireFichier.isAssociationPresent(assocId.getAssocId(), 
				String.valueOf(userId), TypeAssociation.SAC);
		return gestionnaireFichier.ajoutDansCours(coursId, assocId.getAssocId());
	}
	
	@DeleteMapping("{coursId}/files/{assocId}")
	public void retraitFichierCours(@PathVariable Long assocId,
			@PathVariable String coursId, @RequestHeader(name = "X-USER-ID") long userId)
					throws NotFoundException, UnauthorizedException, ProxyUnavailableException{
		authService.isClassOwner(getCoursUUID(coursId), userId);
		gestionnaireFichier.retraitCours(assocId,coursId);
	}

	@GetMapping("{coursId}/files")
	public Page<AssociationFichier> listerFichiersCours(@PathVariable String coursId,
			@RequestHeader(name = "X-USER-ID") long userId,Pageable pagination) 
					throws UnauthorizedException, ProxyUnavailableException, NotFoundException{
		authService.isClassMemberOrOwner(getCoursUUID(coursId), userId);
		return gestionnaireFichier.getListeFichiersAssocies(coursId, 
				TypeAssociation.COURS, pagination)
				.map(AssociationFichier::masquerProprietes);
	}

	@GetMapping("{coursId}/files/{assocId}/info")
	@JsonView(AssociationFichier.Public.class)
	public AssociationFichier getInfoFichierCours(@PathVariable Long assocId,
			@PathVariable String coursId,@RequestHeader(name = "X-USER-ID") long userId)
					throws NotFoundException, UnauthorizedException, ProxyUnavailableException{
		authService.isClassMemberOrOwner(getCoursUUID(coursId), userId);
		gestionnaireFichier.isAssociationPresent(assocId, 
				coursId, TypeAssociation.COURS);
		return gestionnaireFichier.getFichierByAssocId(assocId);
	}

	@GetMapping("{coursId}/files/{assocId}")
	public ResponseEntity<byte[]> getFichierCours(@PathVariable Long assocId,
			@PathVariable String coursId,@RequestHeader(name = "X-USER-ID") long userId)
					throws NotFoundException, IOException, UnauthorizedException, ProxyUnavailableException{
		authService.isClassMemberOrOwner(getCoursUUID(coursId), userId);
		gestionnaireFichier.isAssociationPresent(assocId, 
				coursId, TypeAssociation.COURS);
		return ControllerResponseUtils.lireFichier(
				gestionnaireFichier.lireFichier(assocId));
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
