package inpt.lms.stockage.business;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Arrays;
import java.util.Random;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.util.FileSystemUtils;

import inpt.lms.stockage.business.impl.GestionnaireIOFichierLocalImpl;
import inpt.lms.stockage.controller.exceptions.FileTooBigException;



class IOFichierLocalImplTests {
	public File testFolder;
	public GestionnaireIOFichierLocalImpl gFichier;
	
	@BeforeEach
	void setup() throws IOException {
		testFolder = Files.createTempDirectory("test").toFile();
		gFichier = new GestionnaireIOFichierLocalImpl(testFolder.getAbsolutePath());
	}
	
	@AfterEach
	void clean(){
		FileSystemUtils.deleteRecursively(testFolder);
	}
	
	@Test
	void testShouldSaveFile() throws IOException, FileTooBigException {
		byte[] fakeFile = new byte[1024];
		new Random().nextBytes(fakeFile);
		
		gFichier.ecrireFichier(fakeFile, "dossier-image","");
		
		File[] files = testFolder.listFiles();
		assertEquals(1,files.length);
	}
	
	@Test
	void testShouldThrowAlreadyExists() throws IOException{
		byte[] fakeFile = new byte[1024];
		new Random().nextBytes(fakeFile);
		
		File fichier = new File(testFolder,"dossier-image/fichier");
		fichier.getParentFile().mkdirs();
		fichier.createNewFile();
		assertThrows(IOException.class, 
				() -> gFichier.ecrireFichier(fakeFile, "dossier-image","fichier"));
	}
	
	@Test
	void testShouldReadFile() throws IOException {
		byte[] fakeFile = new byte[10];
		new Random().nextBytes(fakeFile);
		File fichier = new File(testFolder,"fichier");
		Files.write(fichier.toPath(), fakeFile);
		
		byte[] readFile = gFichier.lireFichier(
				new File(testFolder,"fichier").getAbsolutePath());
		assertTrue(Arrays.equals(fakeFile,readFile));
	}
	
	@Test
	void testShouldThrowNotFoundRead(){		
		assertThrows(IOException.class, () -> gFichier.lireFichier("fichier"));
	}
	
	@Test
	void testShouldDeleteFile() throws IOException {
		byte[] fakeFile = new byte[10];
		new Random().nextBytes(fakeFile);
		File fichier = new File(testFolder,"fichier");
		Files.write(fichier.toPath(), fakeFile);
		assertTrue(fichier.exists());
		
		gFichier.supprimerFichier(fichier.getAbsolutePath());
		assertFalse(fichier.exists());
	}
	
	@Test
	void testShoulThrowNotFoundDelete() throws IOException {
		assertThrows(IOException.class, () -> gFichier.supprimerFichier("fichier"));
	}
	
}
