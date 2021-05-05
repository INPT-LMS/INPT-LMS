package inpt.lms.stockage.business.impl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import inpt.lms.stockage.business.interfaces.GestionnaireIOFichier;
import inpt.lms.stockage.business.interfaces.exceptions.FileTooBigException;


/**
 * Implementation du gestionnaire qui utilise le disque local
 */
@Service
public class GestionnaireIOFichierLocalImpl implements GestionnaireIOFichier {
	@Value("${inpt.lms.stockage.maxSize}")
	protected long maxSize;
	@Value("${inpt.lms.stockage.directory}")
	protected String directory;

	@Override
	public String ecrireFichier(byte[] fichier, String chemin, String nom)
			throws IOException, FileTooBigException {
		int sizeMb = fichier.length/1024/1024;
		if (sizeMb > maxSize)
			throw new FileTooBigException(maxSize);
		
		File location = getDossierStockage(directory,chemin);
		
		File fichierDisque = nom.equals("") ? File.createTempFile("file-", "", location)
				: new File(location, nom);
		if (!nom.equals("") && fichierDisque.exists())
			throw new IOException("Fichier déjà présent");
		Files.write(fichierDisque.toPath(), fichier);
		return fichierDisque.getAbsolutePath();
	}
	
	private File getDossierStockage(String directory, String chemin) throws IOException {
		File location = new File(directory,chemin);
		if (!location.isDirectory() && !location.mkdirs())
			throw new IOException("Chemin invalide ou pas de permission");
		return location;
	}

	@Override
	public byte[] lireFichier(String chemin) throws IOException {
		return Files.readAllBytes(Path.of(chemin));
	}
	
	@Override
	public void supprimerFichier(String chemin) throws IOException{
		Files.delete(Path.of(chemin));	
	}

	public long getMaxSize() {
		return maxSize;
	}

	public void setMaxSize(long maxSize) {
		this.maxSize = maxSize;
	}

	public String getDirectory() {
		return directory;
	}

	public void setDirectory(String directory) {
		this.directory = directory;
	}

	public GestionnaireIOFichierLocalImpl(long maxSize, String directory) {
		this.maxSize = maxSize;
		this.directory = directory;
	}
	
	public GestionnaireIOFichierLocalImpl() {}
}
