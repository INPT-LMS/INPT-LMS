package inpt.lms.stockage.business;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.Random;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import inpt.lms.stockage.business.impl.GestionnaireFichierImpl;
import inpt.lms.stockage.business.interfaces.GestionnaireIOFichier;
import inpt.lms.stockage.business.interfaces.exceptions.NotFoundException;
import inpt.lms.stockage.business.interfaces.exceptions.StorageLimitExceededException;
import inpt.lms.stockage.dao.AssociationFichierDAO;
import inpt.lms.stockage.dao.FichierInfoDAO;
import inpt.lms.stockage.model.AssociationFichier;
import inpt.lms.stockage.model.FichierInfo;
import inpt.lms.stockage.model.TypeAssociation;

@ExtendWith(MockitoExtension.class)
class GestionnaireFichierImplTests {
	
	@Mock(name = "gestionnaireIO")
	GestionnaireIOFichier gestionnaireIO;
	@Mock(name = "associationFichierDAO")
	AssociationFichierDAO assocDAO;
	@Mock(name = "fichierInfoDAO")
	FichierInfoDAO fDAO;
	FichierInfo fInfo;
	AssociationFichier assoc;
	
	@InjectMocks
	GestionnaireFichierImpl gFichier;
	
	@BeforeEach
	void setup() {
		fInfo = new FichierInfo();
		fInfo.setChemin("test");
		fInfo.setContentType("mp4");
		fInfo.setDateCreation(LocalDateTime.now());
		fInfo.setId(1l);
		fInfo.setIdProprietaire(10l);
		fInfo.setNom("fichier test");
		fInfo.setSize(1000l);
		
		assoc = new AssociationFichier();
		assoc.setId(5l);
		assoc.setIdCorrespondantAssociation("10");
		assoc.setTypeAssociation(TypeAssociation.SAC);
		assoc.setFichierInfo(fInfo);
	}
	
	@Test
	void testShouldAddSac() throws NotFoundException {
		when(assocDAO.findById(5l)).thenReturn(Optional.of(assoc));
		
		gFichier.ajoutDansSac(10l, 5l);
		
		ArgumentCaptor<AssociationFichier> assocCaptured = ArgumentCaptor.forClass(AssociationFichier.class);
		verify(assocDAO).save(assocCaptured.capture());
		AssociationFichier captured = assocCaptured.getValue();
		
		assertEquals(TypeAssociation.SAC, captured.getTypeAssociation());
		assertEquals("10",captured.getIdCorrespondantAssociation());
		assertEquals(fInfo.getNom(),captured.getFichierInfo().getNom());
	}
	
	@Test
	void testShouldThrowAddSac() throws NotFoundException {
		when(assocDAO.findById(5l)).thenReturn(Optional.empty());
		
		assertThrows(NotFoundException.class, () -> gFichier.ajoutDansSac(10l, 5l));
	}
	
	@Test
	void testShouldRemoveSacAndDelete() throws NotFoundException, IOException {
		when(assocDAO.findByIdAndIdCorrespondantAssociationAndTypeAssociation(
				5l, "10", TypeAssociation.SAC)).thenReturn(Optional.of(assoc));
		when(assocDAO.existsById(5l)).thenReturn(true);
		
		gFichier.retraitSac(10l, 5l);
		
		verify(assocDAO).deleteById(5l);
		verify(gestionnaireIO).supprimerFichier(anyString());
		verify(fDAO).delete(any(FichierInfo.class));
	}
	@Test
	void testShouldThrowWhenDeleteFromSac() throws NotFoundException, IOException {
		when(assocDAO.findByIdAndIdCorrespondantAssociationAndTypeAssociation(
				5l, "10", TypeAssociation.SAC)).thenReturn(Optional.of(assoc));
		when(assocDAO.existsById(5l)).thenReturn(true);
		doThrow(IOException.class).when(gestionnaireIO).supprimerFichier(fInfo.getChemin());
		
		assertThrows(IOException.class, () -> gFichier.retraitSac(10l, 5l));
	}
	
	@Test
	void testShouldUploadFile() throws StorageLimitExceededException, IOException {
		byte[] fakeFile = new byte[20];
		new Random().nextBytes(fakeFile);
		when(gestionnaireIO.ecrireFichier(any(), anyString(), anyString())).thenReturn("path/test");
		
		gFichier.uploadFichierSac(10l, fakeFile, "json", "test", 20);
		
		ArgumentCaptor<FichierInfo> fichierCaptured = ArgumentCaptor.forClass(FichierInfo.class);
		verify(fDAO).save(fichierCaptured.capture());
		FichierInfo captured = fichierCaptured.getValue();
		assertEquals(20, captured.getSize());
		assertEquals("test", captured.getNom());
		assertEquals("json",captured.getContentType());
		assertNotNull(captured.getChemin());
	}
	
	@Test
	void testShouldThrowLimitExceed() throws StorageLimitExceededException, IOException {
		when(fDAO.getUsedSpaceUser(10l)).thenReturn(GestionnaireFichierImpl.MAX_SPACE_PER_USER+1);
		byte[] fakeFile = new byte[20];
		new Random().nextBytes(fakeFile);
		assertThrows(StorageLimitExceededException.class, 
				() -> gFichier.uploadFichierSac(10l, fakeFile, "json", "test", 20));
	}

}
