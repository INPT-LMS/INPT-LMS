package inpt.lms.stockage.controller;

import java.io.IOException;

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
@RequestMapping(path = "/storage/publication", produces = "application/json",
consumes = "application/json")
public class PublicationStockageController {
	@Value("${inpt.lms.stockage.max-size}")
	protected long maxSize;
	@Autowired
	protected GestionnaireFichier gestionnaireFichier;
	@Autowired
	protected AuthorizationService authService;
	
	@PostMapping("{publicationId}/files")
	@JsonView(AssociationFichier.Public.class)
	public AssociationFichier ajoutFichierPublication(@PathVariable String publicationId,
			@RequestBody @Valid ParamAssocId assocId, 
			@RequestHeader(name = "X-USER-ID") long userId) throws NotFoundException, UnauthorizedException, ProxyUnavailableException{
		authService.isPublicationOwner(publicationId, userId);
		return gestionnaireFichier.ajoutDansPublication(publicationId, assocId.getAssocId());
	}
	
	@DeleteMapping("{publicationId}/files/{assocId}")
	public void retraitFichierPublication(@PathVariable Long assocId,
			@PathVariable String publicationId, @RequestHeader(name = "X-USER-ID") long userId)
					throws NotFoundException, UnauthorizedException, ProxyUnavailableException{
		authService.isPublicationOwner(publicationId, userId);
		gestionnaireFichier.retraitPublication(assocId);
	}
	
	@GetMapping("{publicationId}/files")
	public Page<AssociationFichier> listerFichiersPublication(@PathVariable String publicationId,
			@RequestHeader(name = "X-USER-ID") long userId,Pageable pagination) 
					throws UnauthorizedException, ProxyUnavailableException{
		authService.isPublicationClassMemberOrOwner(publicationId, userId);
		return gestionnaireFichier.getListeFichiersAssocies(publicationId, 
				TypeAssociation.PUBLICATION, pagination)
				.map(AssociationFichier::masquerProprietes);
	}
	
	@GetMapping("publicationId}/files/{assocId}/info")
	@JsonView(AssociationFichier.Public.class)
	public AssociationFichier getInfoFichierpublication(@PathVariable Long assocId,
			@PathVariable String publicationId,@RequestHeader(name = "X-USER-ID") long userId)
					throws NotFoundException, UnauthorizedException, ProxyUnavailableException{
		authService.isPublicationClassMemberOrOwner(publicationId, userId);
		return gestionnaireFichier.getFichierByAssocId(assocId);
	}
	
	@GetMapping("{publicationId}/files/{assocId}")
	public ResponseEntity<byte[]> getFichierpublication(@PathVariable Long assocId,
			@PathVariable String publicationId,@RequestHeader(name = "X-USER-ID") long userId)
					throws NotFoundException, IOException, UnauthorizedException, ProxyUnavailableException{
		authService.isPublicationClassMemberOrOwner(publicationId, userId);
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
