package inpt.lms.stockage.controllers;


import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.UUID;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import inpt.lms.stockage.authorization.AuthorizationService;
import inpt.lms.stockage.business.interfaces.GestionnaireFichier;
import inpt.lms.stockage.business.interfaces.GestionnaireIOFichier;
import inpt.lms.stockage.business.interfaces.exceptions.NotFoundException;
import inpt.lms.stockage.model.AssociationFichier;


@WebMvcTest
class StockageControllerTests {
	@Autowired
	public MockMvc mockServeur;
	@MockBean
	public GestionnaireIOFichier gestionnaireIO;
	@MockBean
	public GestionnaireFichier gestionnaireFichier;
	@MockBean
	public AuthorizationService authService;
	
	public UUID fakeUUID = UUID.randomUUID();

	@Test
	void shouldGet404ForAddCours() throws Exception {
		doThrow(NotFoundException.class).when(gestionnaireFichier)
				.ajoutDansCours(fakeUUID.toString(), 17l);
		mockServeur.perform(post(String.format("/storage/class/%s/files", 
				fakeUUID.toString()))
				.content("{\"assocId\": 17}")
				.header("X-USER-ID", 17l)
				.contentType(MediaType.APPLICATION_JSON))
				.andExpect(status().is(404));
	}
	
	@Test
	void shouldAddCoursAndReturnSpecificField() throws Exception {
		AssociationFichier fakeAssoc = new AssociationFichier();
		fakeAssoc.setId(17l);
		fakeAssoc.setIdCorrespondantAssociation("Correspond");
		when(gestionnaireFichier.ajoutDansCours(fakeUUID.toString(),17l)).thenReturn(fakeAssoc);
		
		mockServeur.perform(post(String.format("/storage/class/%s/files", 
						fakeUUID.toString()))
				.content("{\"assocId\": 17}")
				.header("X-USER-ID", 17l)
				.contentType(MediaType.APPLICATION_JSON))
				.andExpect(status().is(200))
				.andExpect(content().json("{id: 17}",true));
	}
}
