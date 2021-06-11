package inpt.lms.stockage.controller;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import feign.RetryableException;
import inpt.lms.stockage.authorization.AuthorizationService;
import inpt.lms.stockage.business.interfaces.GestionnaireFichier;
import inpt.lms.stockage.business.interfaces.exceptions.NotFoundException;
import inpt.lms.stockage.controller.exceptions.FileTooBigException;
import inpt.lms.stockage.controller.exceptions.InvalidFileTypeException;
import inpt.lms.stockage.controller.exceptions.NoContentException;
import inpt.lms.stockage.controller.exceptions.UnauthorizedException;
import inpt.lms.stockage.model.AssociationFichier;
import inpt.lms.stockage.proxies.ProxyUnavailableException;
import inpt.lms.stockage.proxies.comptes.GestionCompteProxy;
import inpt.lms.stockage.proxies.comptes.UserInfos;
import inpt.lms.stockage.proxies.course.GestionCoursProxy;
import inpt.lms.stockage.util.ControllerResponseUtils;

@RestController
@RequestMapping(path = "/storage")
public class DevoirStockageController {
	@Value("${inpt.lms.stockage.max-file-size}")
	protected long maxSize;
	@Autowired
	protected GestionnaireFichier gestionnaireFichier;
	@Autowired
	protected AuthorizationService authService;
	@Autowired
	protected GestionCoursProxy coursProxy;
	@Autowired
	protected GestionCompteProxy compteProxy;
	
	@PostMapping(path = "admin/assignment/{devoirId}", consumes = "multipart/form-data")
	public AssociationFichier uploadReponseDevoir(@RequestParam MultipartFile fichier,
			@RequestHeader(name = "X-USER-ID") long userId,@PathVariable String devoirId)
			throws IOException, FileTooBigException, InvalidFileTypeException,
			ProxyUnavailableException {
		if (fichier.getSize() > maxSize)
			throw new FileTooBigException(maxSize);
		ControllerResponseUtils.checkContentType(fichier);
		
		String filename = new File(fichier.getOriginalFilename()).getName();
		try {
			UserInfos infos = compteProxy.getUserInfos(userId).getUser();
			filename = infos.getNom() + " " + infos.getPrenom() + " - " + filename 
					+ " - no"+ userId;
		} catch (RetryableException e) {
			throw new ProxyUnavailableException();
		}
		AssociationFichier assoc = gestionnaireFichier.uploadReponseDevoir(userId,
				devoirId, fichier.getBytes(), fichier.getContentType(),
				filename, fichier.getSize());
		return AssociationFichier.masquerProprietes(assoc);
	}
	
	@DeleteMapping("admin/assignment/{devoirId}")
	public ResponseEntity<String> deleteReponse(@RequestHeader(name = "X-USER-ID") 
			long userId,@PathVariable String devoirId) throws NotFoundException, IOException {
		gestionnaireFichier.retraitReponseDevoir(userId, devoirId);
		return new ResponseEntity<>(HttpStatus.OK);
	}

	@GetMapping("assignment/{courseId}/{devoirId}")
	public ResponseEntity<byte[]> getOwnReponseDevoir(@RequestHeader(name = "X-USER-ID") 
	long userId,@PathVariable String courseId,@PathVariable String devoirId) 
			throws NotFoundException, IOException, UnauthorizedException, 
			ProxyUnavailableException {
		
		authService.isDevoirClassMember(devoirId, courseId, userId);
		Long idAssocDevoir = gestionnaireFichier.getIdAssocReponseDevoir(userId, devoirId);
		return ControllerResponseUtils.lireFichier(
				gestionnaireFichier.lireFichier(idAssocDevoir));
	}
	
	@GetMapping("assignment/{courseId}/{devoirId}/{eleveId}")
	public ResponseEntity<byte[]> getUserReponseDevoir(@RequestHeader(name = "X-USER-ID") 
	long userId,@PathVariable String courseId,@PathVariable String devoirId,
	@PathVariable long eleveId) throws NotFoundException, IOException,
		UnauthorizedException, 	ProxyUnavailableException {
		
		authService.isDevoirOwner(devoirId, courseId, userId);
		Long idAssocDevoir = gestionnaireFichier.getIdAssocReponseDevoir(eleveId, devoirId);
		return ControllerResponseUtils.lireFichier(
				gestionnaireFichier.lireFichier(idAssocDevoir));
	}

	@GetMapping("assignment/{courseId}/{devoirId}/all")
	public ResponseEntity<byte[]> getAllReponsesDevoir(@RequestHeader(name = "X-USER-ID") 
	long userId,@PathVariable String courseId,@PathVariable String devoirId) 
			throws IOException, UnauthorizedException, 
			ProxyUnavailableException, NoContentException {
		authService.isDevoirOwner(devoirId, courseId, userId);
		byte[] zipFile = gestionnaireFichier.getAllReponseDevoir(devoirId);
		
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION,
				"attachment; filename=\"Reponses devoir " + devoirId + ".zip\"")
				.header(HttpHeaders.CONTENT_TYPE, "application/zip")
				.body(zipFile);
	}
}
