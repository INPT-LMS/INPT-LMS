package inpt.lms.stockage.business.interfaces;

import java.io.IOException;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import inpt.lms.stockage.business.interfaces.exceptions.FileTooBigException;
import inpt.lms.stockage.business.interfaces.exceptions.NotFoundException;
import inpt.lms.stockage.business.interfaces.exceptions.StorageLimitExceededException;
import inpt.lms.stockage.model.FichierInfo;
import inpt.lms.stockage.model.TypeAssociation;

/**
 * Interface pour manipuler le stockage des fichiers
 * @author richard
 *
 */
public interface GestionnaireFichier {
	/**
	 * Ajoute un fichier dans l'espace de stockage logique de l'utilisateur
	 * @param idUtilisateur l'identifiant de l'utilisateur
	 * @param idFichier l'identifiant du fichier
	 * @throws NotFoundException Si le fichier n'est pas trouvé
	 */
	void ajoutDansSac(Long idUtilisateur, Long idFichier) throws NotFoundException;
	
	/**
	 * Retire un fichier de l'espace de stockage d'un utilisateur et eventuellement le 
	 * supprime physiquement s'il n'est plus utilisé
	 * @param idUtilisateur l'identifiant de l'utilisateur
	 * @param idFichier l'identifiant du fichier
	 * @throws NotFoundException Si le fichier n'est pas trouvé
	 * @throws IOException Si la suppression du fichier echoue
	 */
	void retraitSac(Long idUtilisateur,Long idFichier) throws NotFoundException, IOException;
	

	/**
	 * Enregistre physiquement le fichier dans un espace de stockage. Il est automatiquement
	 * ajouté à l'espace de stockage de l'utilisateur
	 * @param idUtilisateur l'identifiant de l'utilisateur
	 * @param fichier le fichier
	 * @param contentType le type de fichier
	 * @param nom le nom du fichier
	 * @param size la taille du fichier (en octets)
	 * @throws StorageLimitExceededException Si l'utilisateur a atteint ou dépasse sa 
	 * limite de stockage
	 * @throws FileTooBigException Si le fichier est trop grand
	 * @throws IOException Si une erreur d'écriture est survenue
	 */
	void uploadFichierSac(Long idUtilisateur, byte[] fichier, String contentType, String nom, long size) 
			throws StorageLimitExceededException,FileTooBigException, IOException;
	
	
	/**
	 * Recupère la liste des fichiers d'un cours, devoir ou d'une publication
	 * @param idAssocie l'identifiant de l'objet dont on veut recuperer les fichiers
	 * associés
	 * @param typeAssociation le type de l'association (et donc de l'objet)
	 * @param pagination La page de données voulues
	 * @return Les données specifiées par la pagination
	 */
	Page<FichierInfo> getListeFichiersAssocies(String idAssocie, TypeAssociation typeAssociation,
			Pageable pagination);
	/**
	 * Recupere un fichier par son id
	 * @param idFichier L'id du fichier
	 * @return Le fichier
	 * @throws NotFoundException Si le fichier n'est pas trouvé
	 */
	FichierInfo getFichier(Long idFichier) throws NotFoundException;
	
	
	/**
	 * Determine l'espace utilisé par l'utilisateur
	 * @param idUtilisateur l'identifiant de l'utilisateur
	 * @return L'espace utilisé par l'utilisateur
	 */
	Long getUsedSpace(Long idUtilisateur);
	
	
}
