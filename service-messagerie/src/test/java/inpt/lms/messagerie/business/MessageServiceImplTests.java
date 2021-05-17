package inpt.lms.messagerie.business;


import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Captor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import inpt.lms.messagerie.business.impl.MessagerieServiceImpl;
import inpt.lms.messagerie.business.interfaces.exceptions.NotFoundException;
import inpt.lms.messagerie.dao.DiscussionDAO;
import inpt.lms.messagerie.dao.MessageDAO;
import inpt.lms.messagerie.model.Discussion;
import inpt.lms.messagerie.model.Message;
import inpt.lms.messagerie.proxies.GestionCompteProxyService;
import inpt.lms.messagerie.proxies.NoSuchUserException;
import inpt.lms.messagerie.proxies.UserInfos;
import inpt.lms.messagerie.proxies.UserWrapper;


@ExtendWith(MockitoExtension.class)
class MessageServiceImplTests {
	@Mock
	public MessageDAO messageDAO;
	@Mock
	public DiscussionDAO discussionDAO;
	@Mock
	public GestionCompteProxyService gestionCompte;
	@InjectMocks
	public MessagerieServiceImpl messagerieService;
	public Message messageTest;
	
	// Ici on utilise l'annotation captor car on ne peut pas créer de capteur 
	// avec les types génériques directement (on peut mais on ne pourra pas préciser
	// le type)
	@Captor
	ArgumentCaptor<Iterable<Message>> capturedMessagesList;
	
	@BeforeEach
	void setup() {
		messageTest = new Message();
		messageTest.setIdDestinataire(5);
		messageTest.setIdEmetteur(10);
		messageTest.setContenu("Bonjour");
	}
	
	@Test
	void testShouldAddMessageAndCreateDiscussion() throws NoSuchUserException {
		UserWrapper mockWrapper = mock(UserWrapper.class);
		when(mockWrapper.getUser()).thenReturn(mock(UserInfos.class));
		when(discussionDAO.findOneByIdParticipant1AndIdParticipant2(
				5, 10)).thenReturn(Optional.empty());
		when(gestionCompte.getUserInfos(any(Long.class))).thenReturn(mockWrapper);
		
		Discussion disc = new Discussion();
		disc.setId("idTest");
		when(discussionDAO.save(any(Discussion.class))).thenReturn(disc);
		
		messagerieService.envoyerMessage(messageTest);
		
		ArgumentCaptor<Message> captured = ArgumentCaptor.forClass(Message.class);
		verify(messageDAO).save(captured.capture());
		assertEquals(disc.getId(),captured.getValue().getIdDiscussion());
	}
	
	@Test
	void testShouldAddMessage() throws NoSuchUserException {
		Discussion disc = new Discussion();
		disc.setId("idTest");
		when(discussionDAO.findOneByIdParticipant1AndIdParticipant2(
				5, 10)).thenReturn(Optional.of(disc));
		
		
		messagerieService.envoyerMessage(messageTest);
		
		ArgumentCaptor<Message> captured = ArgumentCaptor.forClass(Message.class);
		verify(discussionDAO, times(1)).save(any(Discussion.class));
		verify(messageDAO).save(captured.capture());
		assertEquals(disc.getId(),captured.getValue().getIdDiscussion());
	}
	
	@Test
	void testShouldThrowNotFoundDiscussion() {
		when(discussionDAO.existsById("idTest")).thenReturn(false);
		
		assertThrows(NotFoundException.class, () ->
			messagerieService.getDiscussionMessages(
					"idTest", 5, PageRequest.of(0, 20)));
	}
	
	@Test
	void testShouldGetDiscussionMessage() throws NotFoundException {
		Message messageTest2 = new Message();
		messageTest2.setId("IdMessageTest");
		messageTest2.setIdDestinataire(10);
		messageTest2.setIdEmetteur(5);
		messageTest2.setLu(false);
		messageTest.setLu(false);
		
		List<Message> fakeMessages = new ArrayList<>();
		fakeMessages.add(messageTest2);
		fakeMessages.add(messageTest);
		Page<Message> fakePageMessages = new PageImpl<>(fakeMessages);
		Pageable pagination = PageRequest.of(0, 20);
		
		when(discussionDAO.existsById("idTest")).thenReturn(true);
		when(messageDAO.findAllByIdDiscussion(
						"idTest",pagination)).thenReturn(fakePageMessages);
		
		Page<Message> returnedMessages = 
				messagerieService.getDiscussionMessages("idTest", 10, pagination);
		
		assertEquals(2,returnedMessages.getNumberOfElements());
		
		verify(messageDAO).saveAll(capturedMessagesList.capture());
		Iterator<Message> readMessages = capturedMessagesList.getValue().iterator();
		Message firstMessage = readMessages.next();
		assertEquals("IdMessageTest",firstMessage.getId());
		assertTrue(firstMessage.isLu());
		assertFalse(readMessages.hasNext());
	}
}
