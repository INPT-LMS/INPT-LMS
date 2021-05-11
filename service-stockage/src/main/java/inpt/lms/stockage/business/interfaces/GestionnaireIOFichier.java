package inpt.lms.stockage.business.interfaces;

import java.io.IOException;

/**
 * Interface qui définit les méthodes pour manipuler physiquement (écrire ou lire sur
 * le disque par exemple) les fichiers.<br /> L'endroit où les données sont stockées n'est 
 * pas défini (disque, espace cloud, etc)
 *
 */
public interface GestionnaireIOFichier {
	
	/**
	 * Enregistre le fichier
	 * @param fichier Le contenu fichier à enregistrer
	 * @param chemin L'endroit où enregistrer le fichier
	 * @param nom Le nom du fichier. Si vide est géneré.
	 * @throws IOException Si une erreur se produit durant l'ecriture
	 * @return Le chemin pour acceder au fichier
	 */
	String ecrireFichier(byte[] fichier, String chemin, String nom) throws IOException;
	
	/**
	 * Lit un fichier
	 * @param chemin le chemin du fichier
	 * @return La représentation du fichier (en byte)
	 * @throws IOException Si une erreur se produit durant la lecture
	 */
	byte[] lireFichier(String chemin) throws IOException;
	
	/**
	 * Supprime un fichier
	 * @param chemin le chemin du fichier
	 * @throws IOException Si une erreur se produit durant l'opération
	 */
	void supprimerFichier(String chemin) throws IOException;

	/**
	 * Retourne le repertoire/emplacement de stockage
	 * @return Un chemin (uri) qui représente l'emplacement où sont stockés les fichiers
	 */
	String getDirectory();

	/**
	 * Change l'emplacement de stockage
	 * @param directory Le nouvel emplacement de stockage 
	 */
	void setDirectory(String directory);
	
}
