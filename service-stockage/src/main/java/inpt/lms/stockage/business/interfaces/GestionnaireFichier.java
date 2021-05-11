package inpt.lms.stockage.business.interfaces;

import java.io.IOException;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import inpt.lms.stockage.business.interfaces.exceptions.NotFoundException;
import inpt.lms.stockage.business.interfaces.exceptions.StorageLimitExceededException;
import inpt.lms.stockage.model.AssociationFichier;
import inpt.lms.stockage.model.FichierInfo;
import inpt.lms.stockage.model.TypeAssociation;

/**
 * Interface pour manipuler le stockage des fichiers
 *
 */
public interface GestionnaireFichier {
	/**
	 * Ajoute un fichier dans l'espace de stockage logique de l'utilisateur
	 * @param idUtilisateur l'identifiant de l'utilisateur
	 * @param idAssocFichier l'identifiant du fichier dans un cours ou une publication
	 * @throws NotFoundException Si le fichier n'est pas trouvé
	 * @return Les informations sur le fichier ajoute
	 */
	AssociationFichier ajoutDansSac(Long idUtilisateur, Long idAssocFichier) throws NotFoundException;
	
	/**
	 * Retire un fichier de l'espace de stockage d'un utilisateur et eventuellement le 
	 * supprime physiquement s'il n'est plus utilisé
	 * @param idAssoc l'identifiant de l'association
	 * @param idUtilisateur l'identifiant de l'utilisateur
	 * @throws NotFoundException Si le fichier n'est pas trouvé
	 * @throws IOException Si la suppression du fichier echoue
	 */
	void retraitSac(Long idUtilisateur,Long idAssoc) throws NotFoundException, IOException;
	
	/**
	 * Ajoute un fichier dans l'espace de stockage d'un cours
	 * @param idCours l'identifiant du cours
	 * @param idAssocFichier l'identifiant du fichier dans un cours ou une publication
	 * @throws NotFoundException Si le fichier n'est pas trouvé
	 * @return Les informations sur le fichier ajouté
	 */
	AssociationFichier ajoutDansCours(String idCours, Long idAssocFichier) throws NotFoundException;
	
	/**
	 * Retire un fichier de l'espace de stockage d'un cours
	 * @param idAssoc l'identifiant de l'association
	 * @throws NotFoundException Si le fichier n'est pas trouvé
	 */
	void retraitCours(Long idAssoc) throws NotFoundException;
	
	/**
	 * Ajoute un fichier dans une publciation
	 * @param idPublication l'identifiant de la publication
	 * @param idAssocFichier l'identifiant du fichier dans un cours ou une publication
	 * @throws NotFoundException Si le fichier n'est pas trouvé
	 * @return Les informations sur le fichier ajouté
	 */
	AssociationFichier ajoutDansPublication(String idPublication, Long idAssocFichier) 
			throws NotFoundException;
	
	/**
	 * Retire un fichier d'une publication
	 * @param idAssoc l'identifiant de l'association
	 * @throws NotFoundException Si le fichier n'est pas trouvé
	 */
	void retraitPublication(Long idAssoc) throws NotFoundException;
	

	/**
	 * Enregistre physiquement le fichier dans un espace de stockage. Il est automatiquement
	 * ajouté à l'espace de stockage de l'utilisateur
	 * @param idUtilisateur l'identifiant de l'utilisateur
	 * @param fichier le fichier
	 * @param contentType le type de fichier
	 * @param nom le nom du fichier
	 * @param size la taille du fichier (en octets)
	 * @return Les informations sur le fichier ajoute
	 * @throws StorageLimitExceededException Si l'utilisateur a atteint ou dépasse sa 
	 * limite de stockage
	 * @throws IOException Si une erreur d'écriture est survenue
	 * 
	 */
	AssociationFichier uploadFichierSac(Long idUtilisateur, byte[] fichier, String contentType, String nom, long size) 
			throws StorageLimitExceededException, IOException;
	
	
	/**
	 * Recupère la liste des fichiers d'un cours, devoir ou d'une publication
	 * @param idAssocie l'identifiant de l'objet dont on veut recuperer les fichiers
	 * associés
	 * @param typeAssociation le type de l'association (et donc de l'objet)
	 * @param pagination La page de données voulues
	 * @return Les données specifiées par la pagination
	 */
	Page<AssociationFichier> getListeFichiersAssocies(String idAssocie, TypeAssociation typeAssociation,
			Pageable pagination);
	/**
	 * Recupere un fichier par son id
	 * @param idFichier L'id du fichier
	 * @return les informations sur le fichier
	 * @throws NotFoundException Si le fichier n'est pas trouvé
	 */
	FichierInfo getFichier(Long idFichier) throws NotFoundException;
	
	/**
	 * Recupere un fichier associé
	 * @param idAssoc l'identifiant de l'association
	 * @return les informations sur le fichier
	 * @throws NotFoundException Si le fichier n'est pas trouvé
	 */
	AssociationFichier getFichierByAssocId(Long idAssoc) throws NotFoundException;
	
	/**
	 * Determine l'espace utilisé par l'utilisateur
	 * @param idUtilisateur l'identifiant de l'utilisateur
	 * @return L'espace utilisé par l'utilisateur
	 */
	Long getUsedSpace(Long idUtilisateur);
	
	/**
	 * Lit le fichier
	 * @param idAssoc l'identifiant de l'association
	 * @return Le contenu du fichier ainsi que ses informations
	 * @throws IOException Si une erreur se produit lors de la lecture
	 * @throws NotFoundException Si le fichier n'est pas trouvé
	 */
	FichierEtInfo lireFichier(Long idAssoc)  throws IOException,NotFoundException;	
}
