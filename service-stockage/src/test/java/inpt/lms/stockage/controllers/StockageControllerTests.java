package inpt.lms.stockage.controllers;


import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import inpt.lms.stockage.business.interfaces.GestionnaireFichier;
import inpt.lms.stockage.business.interfaces.exceptions.NotFoundException;
import inpt.lms.stockage.model.AssociationFichier;


@WebMvcTest
class StockageControllerTests {
	@Autowired
	public MockMvc mockServeur;
	@MockBean
	public GestionnaireFichier gestionnaireFichier;

	@Test
	void shouldGet404ForAddCours() throws Exception {
		doThrow(NotFoundException.class).when(gestionnaireFichier)
				.ajoutDansCours("e45", 17l);
		mockServeur.perform(post("/storage/class/e45/files")
				.content("{\"assocId\": 17}")
				.contentType(MediaType.APPLICATION_JSON))
				.andExpect(status().is(404));
	}
	
	@Test
	void shouldAddCoursAndReturnSpecificField() throws Exception {
		AssociationFichier fakeAssoc = new AssociationFichier();
		fakeAssoc.setId(17l);
		fakeAssoc.setIdCorrespondantAssociation("Correspond");
		when(gestionnaireFichier.ajoutDansCours("e45",17l)).thenReturn(fakeAssoc);
		
		mockServeur.perform(post("/storage/class/e45/files")
				.content("{\"assocId\": 17}")
				.contentType(MediaType.APPLICATION_JSON))
				.andExpect(status().is(200))
				.andExpect(content().json("{id: 17}",true));
	}
}
