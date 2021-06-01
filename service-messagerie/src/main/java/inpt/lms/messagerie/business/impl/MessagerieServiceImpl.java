package inpt.lms.messagerie.business.impl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import feign.RetryableException;
import inpt.lms.messagerie.business.interfaces.MessagerieService;
import inpt.lms.messagerie.business.interfaces.exceptions.NotFoundException;
import inpt.lms.messagerie.dao.DiscussionDAO;
import inpt.lms.messagerie.dao.MessageDAO;
import inpt.lms.messagerie.model.Discussion;
import inpt.lms.messagerie.model.Message;
import inpt.lms.messagerie.proxies.GestionCompteProxyService;
import inpt.lms.messagerie.proxies.NoSuchUserException;
import inpt.lms.messagerie.proxies.UserInfos;

@Service
public class MessagerieServiceImpl implements MessagerieService {
	@Autowired
	protected MessageDAO messageDAO;
	@Autowired
	protected DiscussionDAO discussionDAO;
	@Autowired
	protected GestionCompteProxyService gestionCompte;

	private void lireMessages(List<Message> messages){
		List<Message> messagesNonLu = new ArrayList<>();
		for (Message m : messages){
			if (!m.isLu()) {
				m.setLu(true);
				messagesNonLu.add(m);
			}	
		}
		if (!messagesNonLu.isEmpty())
			messageDAO.saveAll(messagesNonLu);
	}

	@Override
	public Message envoyerMessage(Message message)throws NoSuchUserException {
		long emetteur = message.getIdEmetteur();
		long destinataire = message.getIdDestinataire();
		long participant1 = emetteur < destinataire ? emetteur : destinataire;
		long participant2 = emetteur < destinataire ? destinataire : emetteur;

		Optional<Discussion> findDiscussion = 
				discussionDAO.findOneByIdParticipant1AndIdParticipant2(
						participant1, participant2);
		Discussion discussion;

		if (findDiscussion.isEmpty()) {
			try {
				UserInfos infosParticipant1 =
						gestionCompte.getUserInfos(participant1).getUser();
				UserInfos infosParticipant2 =
						gestionCompte.getUserInfos(participant2).getUser();
				discussion = new Discussion();
				discussion.setNomParticipant1(
						infosParticipant1.getNom()+" "+infosParticipant1.getPrenom());
				discussion.setNomParticipant2(
						infosParticipant2.getNom()+" "+infosParticipant2.getPrenom());
				discussion.setIdParticipant1(participant1);
				discussion.setIdParticipant2(participant2);
				discussion = discussionDAO.save(discussion);
			} catch (RetryableException e) {
				throw new NoSuchUserException();
			}
		}
		else
			discussion = findDiscussion.get();
		LocalDateTime now = LocalDateTime.now();
		message.setId(null);
		message.setIdDiscussion(discussion.getId());
		message.setDate(now);
		message.setLu(false);
		message = messageDAO.save(message);

		discussion.setLastMessage(message);
		discussion.setLastUpdate(now);
		discussionDAO.save(discussion);
		
		return message;
	}

	@Override
	public Page<Discussion> getDiscussionsUtilisateur(long idUtilisateur,
			Pageable pagination){
		return discussionDAO.findAllByIdParticipant1OrIdParticipant2(idUtilisateur,
				idUtilisateur,pagination);
	}

	@Override
	public Page<Message> getDiscussionMessages(String idDiscussion,long idUtilisateur, 
			Pageable pagination) throws NotFoundException {
		if (!discussionDAO.existsById(idDiscussion))
			throw new NotFoundException();

		Page<Message> messages = messageDAO.findAllByIdDiscussion(
				idDiscussion, pagination);
		lireMessages(messages.filter(m -> m.getIdDestinataire() == idUtilisateur)
				.toList());
		return messages;
	}

	@Override
	public Page<Message> getDiscussionNewMessages(String idDiscussion, 
			long idUtilisateur, Pageable pagination) throws NotFoundException {
		if (!discussionDAO.existsById(idDiscussion))
			throw new NotFoundException();

		Page<Message> messages = 
				messageDAO.findAllByIdDiscussionAndLuAndIdDestinataire(
						idDiscussion, false,idUtilisateur, pagination);
		lireMessages(messages.toList());
		return messages;
	}

	@Override
	public List<String> getDiscussionsWithNewMessages(long idUtilisateur){
		return messageDAO.getAllDiscussionsWithNewMessage(idUtilisateur);
	}

	public MessageDAO getMessageDAO() {
		return messageDAO;
	}
	public void setMessageDAO(MessageDAO messageDAO) {
		this.messageDAO = messageDAO;
	}
	public DiscussionDAO getDiscussionDAO() {
		return discussionDAO;
	}
	public void setDiscussionDAO(DiscussionDAO discussionDAO) {
		this.discussionDAO = discussionDAO;
	}
}
