package inpt.lms.stockage.business.impl;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import inpt.lms.stockage.business.interfaces.FichierEtInfo;
import inpt.lms.stockage.business.interfaces.GestionnaireFichier;
import inpt.lms.stockage.business.interfaces.GestionnaireIOFichier;
import inpt.lms.stockage.business.interfaces.UsedSpaceWrapper;
import inpt.lms.stockage.business.interfaces.exceptions.NotFoundException;
import inpt.lms.stockage.business.interfaces.exceptions.StorageLimitExceededException;
import inpt.lms.stockage.controller.exceptions.NoContentException;
import inpt.lms.stockage.dao.AssociationFichierDAO;
import inpt.lms.stockage.dao.FichierInfoDAO;
import inpt.lms.stockage.model.AssociationFichier;
import inpt.lms.stockage.model.FichierInfo;
import inpt.lms.stockage.model.TypeAssociation;

/**
 * Implementation qui utilise le disque local
 *
 */
@Service
public class GestionnaireFichierImpl implements GestionnaireFichier {
	@Autowired
	protected FichierInfoDAO fichierInfoDAO;
	@Autowired
	protected AssociationFichierDAO associationFichierDAO;
	@Autowired
	protected GestionnaireIOFichier gestionnaireIO;
	public static final long MAX_SPACE_PER_USER = 25600000; // 50 MiB
	
	private void deleteIfPresent(Optional<AssociationFichier> optional) throws IOException {
		if (optional.isPresent()) {
			FichierInfo fInfo = optional.get().getFichierInfo();
			fichierInfoDAO.delete(fInfo);
			gestionnaireIO.supprimerFichier(fInfo.getChemin());
		}
	}

	private FichierInfo recupererFichier(Long idFichier) throws NotFoundException {
		Optional<FichierInfo> fInfo = fichierInfoDAO.findById(idFichier);
		if (fInfo.isEmpty())
			throw new NotFoundException(NotFoundException.ERROR_FILE);
		return fInfo.get();
	}
	
	private AssociationFichier recupererAssociation(Long idAssoc) throws NotFoundException{
		Optional<AssociationFichier> assoc = associationFichierDAO.findById(idAssoc);
		if (assoc.isEmpty())
			throw new NotFoundException(NotFoundException.ERROR_FILE);
		return assoc.get();
	}
	
	private AssociationFichier ajoutAssociation(String idCorrespondant, 
			TypeAssociation type, FichierInfo fInfo) {
		
		AssociationFichier assoc = new AssociationFichier();
		assoc.setFichierInfo(fInfo);
		assoc.setTypeAssociation(type);
		assoc.setIdCorrespondantAssociation(idCorrespondant);
		return associationFichierDAO.save(assoc);
	}
	
	private void retraitAssociation(Long idAssociation) throws NotFoundException{
		if (!associationFichierDAO.existsById(idAssociation))
			throw new NotFoundException(NotFoundException.ERROR_FILE);
		associationFichierDAO.deleteById(idAssociation);
	}
	
	private AssociationFichier ecrireFichierStockage(Long userId,String idCorrespondant,
			byte[] bytes, String contentType, String filename, long size,
			TypeAssociation association) 
					throws IOException {
		FichierInfo fInfo = new FichierInfo();
		fInfo.setContentType(contentType);
		fInfo.setNom(filename);
		fInfo.setIdProprietaire(userId);
		fInfo.setDateCreation(LocalDateTime.now());
		fInfo.setSize(size);
		
		String chemin = gestionnaireIO.ecrireFichier(bytes, "personal-"+userId, "");
		fInfo.setChemin(chemin);
		fInfo = fichierInfoDAO.save(fInfo);
		
		AssociationFichier assoc = new AssociationFichier();
		assoc.setIdCorrespondantAssociation(idCorrespondant);
		assoc.setTypeAssociation(association);
		assoc.setFichierInfo(fInfo);
		return associationFichierDAO.save(assoc);
	}
	
	@Override
	public Page<AssociationFichier> getFichierParNom(String partieNom,
			String idCorrespondant,TypeAssociation typeAssociation,Pageable page) {
		return associationFichierDAO.findAllByFichierInfo_NomIgnoreCaseContainingAndIdCorrespondantAssociationAndTypeAssociation(
				partieNom, idCorrespondant, typeAssociation, page);
	}

	@Override
	public void isAssociationPresent(Long idAssoc, String idAssocie,
			TypeAssociation typeAssociation) throws NotFoundException{
		if (!associationFichierDAO.existsByIdAndIdCorrespondantAssociationAndTypeAssociation(
				idAssoc, idAssocie, typeAssociation))
			throw new NotFoundException(NotFoundException.ERROR_FILE);
	}
	
	@Override
	public AssociationFichier ajoutDansCours(String idCours, Long idAssocFichier) throws NotFoundException {
		return ajoutAssociation(idCours, TypeAssociation.COURS,
				recupererAssociation(idAssocFichier).getFichierInfo());
		
	}

	@Override
	@Transactional(rollbackOn = IOException.class)
	public void retraitSac(Long idUtilisateur,Long idAssoc) 
			throws NotFoundException, IOException {
		AssociationFichier assoc = 
				associationFichierDAO.findByIdAndIdCorrespondantAssociationAndTypeAssociation(
						idAssoc, idUtilisateur.toString(),TypeAssociation.SAC).orElseThrow(
						() -> new NotFoundException(NotFoundException.ERROR_FILE));
		FichierInfo info = assoc.getFichierInfo();
		retraitAssociation(idAssoc);	
		if (idUtilisateur.equals(info.getIdProprietaire())) {
			fichierInfoDAO.delete(info);
			gestionnaireIO.supprimerFichier(info.getChemin());
		}	
	}
	
	@Override
	public void retraitCours(Long idAssoc,String idCours) throws NotFoundException {
		isAssociationPresent(idAssoc, idCours, TypeAssociation.COURS);
		retraitAssociation(idAssoc);
	}
	
	@Override
	public AssociationFichier ajoutDansPublication(String idPublication, Long idAssocFichier) throws NotFoundException {
		return ajoutAssociation(idPublication, TypeAssociation.PUBLICATION,
				recupererAssociation(idAssocFichier).getFichierInfo());
	}

	@Override
	public void retraitPublication(Long idAssoc,String idPublication) 
			throws NotFoundException {
		isAssociationPresent(idAssoc, idPublication, TypeAssociation.PUBLICATION);
		retraitAssociation(idAssoc);	
	}

	@Override
	public AssociationFichier uploadFichierSac(Long idUtilisateur, byte[] fichier, 
			String contentType, String nom, long size) 
					throws StorageLimitExceededException,IOException {
		long usedSpace = getUsedSpace(idUtilisateur).getUsedSpace();
		if (usedSpace + size > MAX_SPACE_PER_USER)
			throw new StorageLimitExceededException();
		
		return ecrireFichierStockage(idUtilisateur,idUtilisateur.toString(), fichier,
				contentType, nom, size,TypeAssociation.SAC);
	}

	@Override
	public Page<AssociationFichier> getListeFichiersAssocies(String idAssocie, TypeAssociation typeAssociation,
			Pageable pagination) {
		return associationFichierDAO.findAllByIdCorrespondantAssociationAndTypeAssociation(
						idAssocie, typeAssociation, pagination);
	}

	@Override
	public FichierInfo getFichier(Long idFichier) throws NotFoundException {
		return recupererFichier(idFichier);
	}
	
	@Override
	public UsedSpaceWrapper getUsedSpace(Long idUtilisateur) {
		Long usedSpace = fichierInfoDAO.getUsedSpaceUser(idUtilisateur);
		// Si l'utilisateur ne possede aucun fichier le resultat sera NULL (au lieu de 0)
		return new UsedSpaceWrapper(usedSpace == null ? 0 : usedSpace, MAX_SPACE_PER_USER);
	}
	
	@Override
	public FichierEtInfo lireFichier(Long idAssoc) 
			throws IOException, NotFoundException {
		FichierEtInfo fichier = new FichierEtInfo();
		
		FichierInfo info = recupererAssociation(idAssoc).getFichierInfo();
		fichier.setFichierInfo(info);
		fichier.setFichierContenu(gestionnaireIO.lireFichier(info.getChemin()));
		return fichier;
	}
	
	@Override
	public AssociationFichier getFichierByAssocId(Long idAssoc) throws NotFoundException{
		return recupererAssociation(idAssoc);
	}
	
	@Override
	public AssociationFichier uploadPhotoProfil(long userId, byte[] bytes, 
			String contentType, String filename, long size) throws IOException {
		Optional<AssociationFichier> oldPicture = associationFichierDAO.findByIdCorrespondantAssociationAndTypeAssociation(
				String.valueOf(userId), TypeAssociation.PROFIL_PICTURE);
		AssociationFichier newPicture = 
				ecrireFichierStockage(userId,String.valueOf(userId), bytes, contentType,
						filename, size, TypeAssociation.PROFIL_PICTURE);
		deleteIfPresent(oldPicture);
		return newPicture;
	}
	
	@Override
	public void retraitPhotoProfil(long userId) throws NotFoundException, IOException {
		Optional<AssociationFichier> oldPicture = associationFichierDAO.findByIdCorrespondantAssociationAndTypeAssociation(
				String.valueOf(userId), TypeAssociation.PROFIL_PICTURE);
		deleteIfPresent(oldPicture);	
	}
	
	@Override
	public Long getIdAssocPhotoUser(Long userId) throws NotFoundException {
		Optional<AssociationFichier> assocFichier = associationFichierDAO.findByIdCorrespondantAssociationAndTypeAssociation(
				userId.toString(), TypeAssociation.PROFIL_PICTURE);
		if (assocFichier.isEmpty())
			throw new NotFoundException("photo profil");
		return assocFichier.get().getId();
	}
	
	@Override
	public AssociationFichier uploadReponseDevoir(long userId, String devoirId, byte[] reponse, String contentType,
			String filename, long size) throws IOException {
		Optional<AssociationFichier> oldReponse = associationFichierDAO.findByIdCorrespondantAssociationAndTypeAssociationAndFichierInfo_IdProprietaire(
				devoirId, TypeAssociation.ASSIGNMENT_RESPONSE,userId);
		AssociationFichier newReponse = 
				ecrireFichierStockage(userId,devoirId,reponse, contentType, filename, size, 
						TypeAssociation.ASSIGNMENT_RESPONSE);
		deleteIfPresent(oldReponse);
		return newReponse;
	}

	@Override
	public Long getIdAssocReponseDevoir(Long userId, String devoirId) throws NotFoundException {
		Optional<AssociationFichier> assocFichier = associationFichierDAO.findByIdCorrespondantAssociationAndTypeAssociationAndFichierInfo_IdProprietaire(
				devoirId, TypeAssociation.ASSIGNMENT_RESPONSE,userId);
		if (assocFichier.isEmpty())
			throw new NotFoundException("reponse devoir");
		return assocFichier.get().getId();
	}

	@Override
	public void retraitReponseDevoir(long userId, String devoirId) throws NotFoundException, IOException {
		Optional<AssociationFichier> oldReponse = associationFichierDAO.findByIdCorrespondantAssociationAndTypeAssociationAndFichierInfo_IdProprietaire(
				devoirId, TypeAssociation.ASSIGNMENT_RESPONSE,userId);
		deleteIfPresent(oldReponse);
	}
	
	@Override
	public byte[] getAllReponseDevoir(String devoirId) throws NoContentException,
		IOException {
		List<FichierInfo> reponsesDevoir = fichierInfoDAO.findAllByAssociations_IdCorrespondantAssociationAndAssociations_TypeAssociation(
				devoirId, TypeAssociation.ASSIGNMENT_RESPONSE);
		if (reponsesDevoir.isEmpty())
			throw new NoContentException();
		
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		ZipOutputStream outputZip = new ZipOutputStream(outputStream);
		ZipEntry entry;

		for (FichierInfo fInfo : reponsesDevoir) {
			entry = new ZipEntry(fInfo.getNom()+" - no"+fInfo.getIdProprietaire());
			outputZip.putNextEntry(entry);
			outputZip.write(gestionnaireIO.lireFichier(fInfo.getChemin()));
			outputZip.closeEntry();
		}
		outputZip.close();
		return outputStream.toByteArray();
	}

	public FichierInfoDAO getFichierInfoDAO() {
		return fichierInfoDAO;
	}

	public void setFichierInfoDAO(FichierInfoDAO fichierInfoDAO) {
		this.fichierInfoDAO = fichierInfoDAO;
	}

	public AssociationFichierDAO getAssociationFichierDAO() {
		return associationFichierDAO;
	}

	public void setAssociationFichierDAO(AssociationFichierDAO associationFichierDAO) {
		this.associationFichierDAO = associationFichierDAO;
	}

	public GestionnaireIOFichier getGestionnaireIO() {
		return gestionnaireIO;
	}

	public void setGestionnaireIO(GestionnaireIOFichier gestionnaireIO) {
		this.gestionnaireIO = gestionnaireIO;
	}
}
