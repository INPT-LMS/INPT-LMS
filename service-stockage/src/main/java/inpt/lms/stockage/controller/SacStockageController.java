package inpt.lms.stockage.controller;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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

import com.fasterxml.jackson.annotation.JsonView;

import inpt.lms.stockage.business.interfaces.GestionnaireFichier;
import inpt.lms.stockage.business.interfaces.UsedSpaceWrapper;
import inpt.lms.stockage.business.interfaces.exceptions.NotFoundException;
import inpt.lms.stockage.business.interfaces.exceptions.StorageLimitExceededException;
import inpt.lms.stockage.controller.exceptions.FileTooBigException;
import inpt.lms.stockage.controller.exceptions.InvalidFileTypeException;
import inpt.lms.stockage.model.AssociationFichier;
import inpt.lms.stockage.model.TypeAssociation;
import inpt.lms.stockage.util.ControllerResponseUtils;

@RestController
@RequestMapping(path = "/storage/user")
public class SacStockageController {
	@Value("${inpt.lms.stockage.max-file-size}")
	protected long maxSize;
	protected long maxPictureSize = 5242880; // 5MB
	protected List<String> supportedPictureTypes = Arrays.asList("image/jpeg", "image/png");
	@Autowired
	protected GestionnaireFichier gestionnaireFichier;

	@PostMapping(path = "picture", consumes = "multipart/form-data")
	public AssociationFichier uploadPhotoProfil(@RequestParam MultipartFile fichier,
			@RequestHeader(name = "X-USER-ID") long userId)
			throws IOException, FileTooBigException, InvalidFileTypeException {
		if (fichier.getSize() > maxPictureSize)
			throw new FileTooBigException(maxPictureSize);
		
		ControllerResponseUtils.checkContentType(fichier, supportedPictureTypes);
		
		String filename = "picture-user-"+userId;
		AssociationFichier assoc = gestionnaireFichier.uploadPhotoProfil(userId, 
				fichier.getBytes(), fichier.getContentType(),filename, fichier.getSize());
		return AssociationFichier.masquerProprietes(assoc);
	}

	@DeleteMapping("picture")
	public ResponseEntity<String> deletePhotoProfil(@RequestHeader(name = "X-USER-ID") 
			long userId) throws NotFoundException, IOException {
		gestionnaireFichier.retraitPhotoProfil(userId);
		return new ResponseEntity<>(HttpStatus.OK);
	}

	@GetMapping("picture/{userId}")
	public ResponseEntity<byte[]> getPhotoProfil(@PathVariable Long userId) throws NotFoundException, IOException {
		Long idAssocPhoto = gestionnaireFichier.getIdAssocPhotoUser(userId);
		return ControllerResponseUtils.lireFichierAvecCache(
				gestionnaireFichier.lireFichier(idAssocPhoto));
	}

	@PostMapping(path = "upload", consumes = "multipart/form-data")
	public AssociationFichier uploadFichierSac(@RequestParam MultipartFile fichier,
			@RequestHeader(name = "X-USER-ID") long userId)
			throws IOException, StorageLimitExceededException, 
			FileTooBigException, InvalidFileTypeException {
		ControllerResponseUtils.checkContentType(fichier);
		if (fichier.getSize() > maxSize)
			throw new FileTooBigException(maxSize);
		String filename = new File(fichier.getOriginalFilename()).getName();
		AssociationFichier assoc = gestionnaireFichier.uploadFichierSac(userId, fichier.getBytes(),
				fichier.getContentType(), filename, fichier.getSize());
		return AssociationFichier.masquerProprietes(assoc);
	}

	@DeleteMapping("files/{assocId}")
	public void retraitFichierSac(@PathVariable Long assocId, @RequestHeader(name = "X-USER-ID") long userId)
			throws NotFoundException, IOException {
		gestionnaireFichier.retraitSac(userId, assocId);
	}

	@GetMapping("files")
	public Page<AssociationFichier> listerFichiersSac(@RequestHeader(name = "X-USER-ID") long userId,
			Pageable pagination) {
		return gestionnaireFichier.getListeFichiersAssocies(String.valueOf(userId), TypeAssociation.SAC, pagination)
				.map(AssociationFichier::masquerProprietes);
	}

	@GetMapping("files/{assocId}/info")
	@JsonView(AssociationFichier.Public.class)
	public AssociationFichier getInfoFichierSac(@PathVariable Long assocId,
			@RequestHeader(name = "X-USER-ID") long userId) throws NotFoundException {
		gestionnaireFichier.isAssociationPresent(assocId, String.valueOf(userId), TypeAssociation.SAC);
		return gestionnaireFichier.getFichierByAssocId(assocId);
	}

	@GetMapping("files/{assocId}")
	public ResponseEntity<byte[]> getFichierSac(@PathVariable Long assocId,
			@RequestHeader(name = "X-USER-ID") long userId) throws NotFoundException, IOException {
		gestionnaireFichier.isAssociationPresent(assocId, String.valueOf(userId), TypeAssociation.SAC);
		return ControllerResponseUtils.lireFichier(gestionnaireFichier.lireFichier(assocId));
	}
	
	@GetMapping("space")
	public UsedSpaceWrapper getUsedSpace(@RequestHeader(name = "X-USER-ID")
			long userId) {
		return gestionnaireFichier.getUsedSpace(userId);
	}
	
	@GetMapping("search")
	public Page<AssociationFichier> searchFichiers(@RequestHeader(name = "X-USER-ID")
			long userId,@RequestParam(name = "name",required = true) String partieNom,
			Pageable page){
		return gestionnaireFichier.getFichierParNom(partieNom,String.valueOf(userId),
				TypeAssociation.SAC,page)
				.map(AssociationFichier::masquerProprietes);
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
