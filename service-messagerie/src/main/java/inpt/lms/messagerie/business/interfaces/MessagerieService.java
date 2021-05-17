package inpt.lms.messagerie.business.interfaces;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import inpt.lms.messagerie.business.interfaces.exceptions.NotFoundException;
import inpt.lms.messagerie.model.Discussion;
import inpt.lms.messagerie.model.Message;
import inpt.lms.messagerie.proxies.NoSuchUserException;

public interface MessagerieService {

	void envoyerMessage(Message message) throws NoSuchUserException;

	Page<Discussion> getDiscussionsUtilisateur(long idUtilisateur, Pageable pagination);

	List<String> getDiscussionsWithNewMessages(long idUtilisateur);

	Page<Message> getDiscussionNewMessages(String idDiscussion, long idUtilisateur, 
			Pageable pagination) throws NotFoundException;

	Page<Message> getDiscussionMessages(String idDiscussion, long idUtilisateur, 
			Pageable pagination) throws NotFoundException;

}