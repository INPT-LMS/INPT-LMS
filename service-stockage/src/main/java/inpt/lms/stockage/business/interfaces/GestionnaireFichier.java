package inpt.lms.stockage.business.interfaces;

import java.io.IOException;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import inpt.lms.stockage.business.interfaces.exceptions.NotFoundException;
import inpt.lms.stockage.business.interfaces.exceptions.StorageLimitExceededException;
import inpt.lms.stockage.controller.exceptions.NoContentException;
import inpt.lms.stockage.model.AssociationFichier;
import inpt.lms.stockage.model.FichierInfo;
import inpt.lms.stockage.model.TypeAssociation;
//TODO: Decoupage en plusieurs classes abstraites + superclasse
/**
 * Interface pour manipuler le stockage des fichiers
 *
 */
public interface GestionnaireFichier {
	/**
	 * Recupere les fichiers qui ont un nom semblable à la chaine de caractere fournie
	 * @param partieNom La chaine de caractere à chercher dans les noms
	 * @param typeAssociation Le type d'association
	 * @param idCorrespondant L'identifiant de l'associé
	 * @param page La page de données voulue
	 * @return Les fichiers dont le nom contient la chaine
	 */
	Page<AssociationFichier> getFichierParNom(String partieNom, String idCorrespondant,
			TypeAssociation typeAssociation, Pageable page);
	
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
	 * @param idCours l'identifiant du cours
	 * @throws NotFoundException Si le fichier n'est pas trouvé
	 */
	void retraitCours(Long idAssoc, String idCours) throws NotFoundException;
	
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
	 * @param publicationId L'id de la publication
	 * @throws NotFoundException Si le fichier n'est pas trouvé
	 */
	void retraitPublication(Long idAssoc, String publicationId) throws NotFoundException;
	

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
	 * Determine l'espace utilisé par l'utilisateur sur son espace total
	 * @param idUtilisateur l'identifiant de l'utilisateur
	 * @return L'espace utilisé par l'utilisateur
	 */
	UsedSpaceWrapper getUsedSpace(Long idUtilisateur);
	
	/**
	 * Lit le fichier
	 * @param idAssoc l'identifiant de l'association
	 * @return Le contenu du fichier ainsi que ses informations
	 * @throws IOException Si une erreur se produit lors de la lecture
	 * @throws NotFoundException Si le fichier n'est pas trouvé
	 */
	FichierEtInfo lireFichier(Long idAssoc)  throws IOException,NotFoundException;

	/**
	 * Vérifie l'existence d'une association
	 * @param idAssoc
	 * @param idAssocie
	 * @param typeAssociation
	 * @throws NotFoundException
	 */
	void isAssociationPresent(Long idAssoc, String idAssocie, TypeAssociation typeAssociation)
			throws NotFoundException;

	/**
	 * Enregistre une photo de profil pour l'utilisateur
	 * @param userId l'identifiant de l'utilisateur
	 * @param photo le fichier
	 * @param contentType le type de fichier
	 * @param nom le nom du fichier
	 * @param size la taille du fichier (en octets)
	 * @return Les informations sur le fichier ajoute
	 * @throws IOException Si une erreur d'écriture est survenue
	 * 
	 */
	AssociationFichier uploadPhotoProfil(long userId, byte[] photo, 
			String contentType, String filename, long size) throws IOException;

	/**
	 * Recupere l'identifiant de l'association de la photo de l'utilisateur
	 * @param userId l'id de l'utilisateur
	 * @return l'identifiant de l'association
	 * @throws NotFoundException Si l'utilisateur n'existe pas ou n'a pas de photo
	 */
	Long getIdAssocPhotoUser(Long userId) throws NotFoundException;

	/**
	 * Supprime la photo de profil de l'utilisateur
	 * @param userId l'identifiant de l'utilisateur
	 * @throws NotFoundException Si l'utilisateur n'a pas de photo de profil
	 * @throws IOException Si une erreur a lieu durant la suppression
	 */
	void retraitPhotoProfil(long userId) throws NotFoundException,IOException;
	
	/**
	 * Enregistre une réponse à un devoir pour un utilisateur
	 * @param userId l'identifiant de l'utilisateur
	 * @param devoirId l'identifiant du devoir
	 * @param reponse le fichier
	 * @param contentType le type de fichier
	 * @param nom le nom du fichier
	 * @param size la taille du fichier (en octets)
	 * @return Les informations sur le fichier ajoute
	 * @throws IOException Si une erreur d'écriture est survenue
	 * 
	 */
	AssociationFichier uploadReponseDevoir(long userId,String devoirId, byte[] reponse, 
			String contentType, String filename, long size) throws IOException;

	/**
	 * Recupere l'identifiant de la reponse à un devoir
	 * @param userId l'id de l'utilisateur
	 * @param devoirId l'identifiant du devoir
	 * @return l'identifiant de l'association
	 * @throws NotFoundException Si l'utilisateur n'existe pas ou n'a pas répondu au devoir
	 */
	Long getIdAssocReponseDevoir(Long userId,String devoirId) throws NotFoundException;

	/**
	 * Supprime la réponse de l'utilisateur au devoir
	 * @param userId l'identifiant de l'utilisateur
	 * param devoirId l'identifiant du devoir
	 * @throws NotFoundException Si l'utilisateur n'a pas répondu au devoir
	 * @throws IOException Si une erreur a lieu durant la suppression
	 */
	void retraitReponseDevoir(long userId,String devoirId) throws NotFoundException,IOException;
	
	/**
	 * Renvoie toutes les réponses à un devoir sous forme de fichier zip 
	 * @param devoirId L'identifiant du devoir
	 * @return Un fichier zip sous forme de bytes
	 * @throws NoContentException Si aucune réponse au devoir n'est trouvée
	 * @throws IOException
	 */
	byte[] getAllReponseDevoir(String devoirId) throws NoContentException,IOException;
	
	/**
	 * Enregistre le sujet d'un devoir
	 * @param userId l'identifiant du prof
	 * @param devoirId l'identifiant du devoir
	 * @param sujet le sujet du devoir
	 * @param contentType le type de fichier
	 * @param nom le nom du fichier
	 * @param size la taille du fichier (en octets)
	 * @return Les informations sur le fichier ajoute
	 * @throws IOException Si une erreur d'écriture est survenue
	 * 
	 */
	AssociationFichier uploadSujetDevoir(long userId,String devoirId, byte[] sujet, 
			String contentType, String filename, long size) throws IOException;

	/**
	 * Recupere l'identifiant du sujet d'un devoir
	 * @param devoirId l'identifiant du devoir
	 * @return l'identifiant de l'association
	 * @throws NotFoundException Si l'utilisateur n'existe pas ou n'a pas répondu au devoir
	 */
	Long getIdAssocSujetDevoir(String devoirId) throws NotFoundException;

	/**
	 * Supprime le sujet d'un devoir
	 * @param userId l'identifiant de l'utilisateur
	 * param devoirId l'identifiant du devoir
	 * @throws NotFoundException Si le sujet n'existe pas
	 * @throws IOException Si une erreur a lieu durant la suppression
	 */
	void retraitSujetDevoir(String devoirId) 
			throws NotFoundException,IOException;

}
