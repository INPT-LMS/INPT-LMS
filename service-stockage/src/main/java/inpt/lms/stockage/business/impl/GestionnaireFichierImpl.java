package inpt.lms.stockage.business.impl;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import inpt.lms.stockage.business.interfaces.GestionnaireFichier;
import inpt.lms.stockage.business.interfaces.GestionnaireIOFichier;
import inpt.lms.stockage.business.interfaces.exceptions.FileTooBigException;
import inpt.lms.stockage.business.interfaces.exceptions.NotFoundException;
import inpt.lms.stockage.business.interfaces.exceptions.StorageLimitExceededException;
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
	public static final long MAX_SPACE_PER_USER = 256000000; // 500 MiB
	
	private FichierInfo recupererFichier(Long idFichier) throws NotFoundException {
		Optional<FichierInfo> fInfo = fichierInfoDAO.findById(idFichier);
		if (fInfo.isEmpty())
			throw new NotFoundException("fichier");
		return fInfo.get();
	}

	@Override
	public void ajoutDansSac(Long idUtilisateur, Long idFichier) throws NotFoundException{
		FichierInfo fInfo = recupererFichier(idFichier);
		
		AssociationFichier assoc = new AssociationFichier();
		assoc.setFichierInfo(fInfo);
		assoc.setTypeAssociation(TypeAssociation.SAC);
		assoc.setIdCorrespondantAssociation(idUtilisateur.toString());
		associationFichierDAO.save(assoc);
	}

	@Override
	@Transactional(rollbackOn = IOException.class)
	public void retraitSac(Long idUtilisateur, Long idFichier) throws NotFoundException, IOException {
		FichierInfo fInfo = recupererFichier(idFichier);
		associationFichierDAO.deleteByFichierInfo_IdAndTypeAssociation(idFichier,
				TypeAssociation.SAC);
		if (fInfo.getIdProprietaire().equals(idUtilisateur)) {
			fichierInfoDAO.deleteById(idFichier);
			gestionnaireIO.supprimerFichier(fInfo.getChemin());
		}	
	}

	@Override
	public void uploadFichierSac(Long idUtilisateur, byte[] fichier, String contentType, String nom, long size)
			throws StorageLimitExceededException, FileTooBigException, IOException {
		long usedSpace = getUsedSpace(idUtilisateur);
		if (usedSpace + size > MAX_SPACE_PER_USER)
			throw new StorageLimitExceededException();
		
		FichierInfo fInfo = new FichierInfo();
		fInfo.setContentType(contentType);
		fInfo.setNom(nom);
		fInfo.setIdProprietaire(idUtilisateur);
		fInfo.setDateCreation(LocalDateTime.now());
		fInfo.setSize(size);
		
		String chemin = gestionnaireIO.ecrireFichier(fichier, "personal-"+idUtilisateur, "");
		fInfo.setChemin(chemin);
		fInfo = fichierInfoDAO.save(fInfo);
		
		AssociationFichier assoc = new AssociationFichier();
		assoc.setIdCorrespondantAssociation(idUtilisateur.toString());
		assoc.setTypeAssociation(TypeAssociation.SAC);
		assoc.setFichierInfo(fInfo);
		associationFichierDAO.save(assoc);
	}

	@Override
	public Page<FichierInfo> getListeFichiersAssocies(String idAssocie, TypeAssociation typeAssociation,
			Pageable pagination) {
		return fichierInfoDAO.findByAssociations_IdCorrespondantAssociationAndAssociations_TypeAssociation(
				idAssocie, typeAssociation, pagination);
	}

	@Override
	public FichierInfo getFichier(Long idFichier) throws NotFoundException {
		return recupererFichier(idFichier);
	}

	@Override
	public Long getUsedSpace(Long idUtilisateur) {
		return fichierInfoDAO.getUsedSpaceUser(idUtilisateur);
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
