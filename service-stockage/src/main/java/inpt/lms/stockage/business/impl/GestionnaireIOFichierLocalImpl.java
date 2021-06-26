package inpt.lms.stockage.business.impl;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

import inpt.lms.stockage.business.interfaces.GestionnaireIOFichier;


/**
 * Implementation du gestionnaire qui utilise le disque local
 */

public class GestionnaireIOFichierLocalImpl implements GestionnaireIOFichier {
	protected String directory;

	public GestionnaireIOFichierLocalImpl() {}
	
	public GestionnaireIOFichierLocalImpl(String directory) {
		this.directory = directory;
	}

	@Override
	public String ecrireFichier(byte[] fichier, String chemin, String nom)
			throws IOException {
		
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
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		try(FileInputStream in = new FileInputStream(chemin)){
			byte[] b = new byte[2048];
			while (in.read(b) != -1)
				out.write(b);
		}
		return out.toByteArray();
	}
	
	@Override
	public void supprimerFichier(String chemin) throws IOException{
		Files.delete(Path.of(chemin));	
	}

	public String getDirectory() {
		return directory;
	}

	public void setDirectory(String directory) {
		this.directory = directory;
	}
}
