package inpt.lms.stockage.controller;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonView;

import inpt.lms.stockage.business.interfaces.FichierEtInfo;
import inpt.lms.stockage.business.interfaces.GestionnaireFichier;
import inpt.lms.stockage.business.interfaces.exceptions.FileTooBigException;
import inpt.lms.stockage.business.interfaces.exceptions.NotFoundException;
import inpt.lms.stockage.business.interfaces.exceptions.StorageLimitExceededException;
import inpt.lms.stockage.model.AssociationFichier;
import inpt.lms.stockage.model.FichierInfo;
import inpt.lms.stockage.model.TypeAssociation;
import inpt.lms.stockage.view.ParamAssocId;

@RestController
@RequestMapping(path = "/storage", produces = "application/json",
consumes = "application/json")
public class StockageController {
	
	@Autowired
	protected GestionnaireFichier gestionnaireFichier;
	
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
			@RequestBody ParamAssocId assocId) throws NotFoundException{
		return gestionnaireFichier.ajoutDansCours(coursId, assocId.getAssocId());
	}
	
	@PostMapping("user/{userId}/files")
	@JsonView(AssociationFichier.Public.class)
	public AssociationFichier ajoutFichierSac(@PathVariable Long userId,
			@RequestBody ParamAssocId assocId) throws NotFoundException{
		return gestionnaireFichier.ajoutDansSac(userId, assocId.getAssocId());
	}

	@DeleteMapping("class/{coursId}/files/{assocId}")
	public void retraitFichierCours(@PathVariable Long assocId,
			@PathVariable String coursId) throws NotFoundException{
		
		gestionnaireFichier.retraitCours(assocId);
	}
	
	@DeleteMapping("user/{userId}/files/{assocId}")
	public void retraitFichierSac(@PathVariable Long assocId,
			@PathVariable Long userId) throws NotFoundException, IOException{
		
		gestionnaireFichier.retraitSac(userId,assocId);
	}
	
	@GetMapping("user/{userId}/files")
	public Page<AssociationFichier> listerFichiersSac(@PathVariable Long userId, Pageable pagination){
		return gestionnaireFichier.getListeFichiersAssocies(userId.toString(), 
				TypeAssociation.SAC, pagination)
				.map(AssociationFichier::masquerProprietes);
	}
	
	@GetMapping("cours/{coursId}/files")
	public Page<AssociationFichier> listerFichiersCours(@PathVariable String coursId, 
			Pageable pagination){
		return gestionnaireFichier.getListeFichiersAssocies(coursId, 
				TypeAssociation.COURS, pagination)
				.map(AssociationFichier::masquerProprietes);
	}

	@GetMapping("class/{coursId}/files/{assocId}/info")
	@JsonView(AssociationFichier.Public.class)
	public AssociationFichier getInfoFichierCours(@PathVariable Long assocId,
			@PathVariable String coursId) throws NotFoundException{
		return gestionnaireFichier.getFichierByAssocId(assocId);
	}
	
	@GetMapping("class/{coursId}/files/{assocId}")
	public ResponseEntity<byte[]> getFichierCours(@PathVariable Long assocId,
			@PathVariable String coursId) throws NotFoundException, IOException{
		
		return lireFichier(assocId);
	}
	
	@GetMapping("user/{userId}/files/{assocId}/info")
	@JsonView(AssociationFichier.Public.class)
	public AssociationFichier getInfoFichierSac(@PathVariable Long assocId,
			@PathVariable Long userId) throws NotFoundException{
		return gestionnaireFichier.getFichierByAssocId(assocId);
	}
	
	@GetMapping("user/{userId}/files/{assocId}")
	public ResponseEntity<byte[]> getFichierSac(@PathVariable Long assocId,
			@PathVariable Long userId) throws NotFoundException, IOException{
		
		return lireFichier(assocId);
	}
	
	@PostMapping(path = "user/{userId}/files", consumes = "multipart/form-data")
	public AssociationFichier uploadFichierSac(@PathVariable Long userId, @RequestParam MultipartFile fichier)
			throws IOException, StorageLimitExceededException, FileTooBigException{
		String filename = new File(fichier.getOriginalFilename()).getName();
		AssociationFichier assoc = gestionnaireFichier.uploadFichierSac(userId, 
				fichier.getBytes(),fichier.getContentType(),filename,fichier.getSize());
		return AssociationFichier.masquerProprietes(assoc);
	}
	
}
