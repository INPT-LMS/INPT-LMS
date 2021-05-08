package inpt.lms.messagerie.controllers;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import feign.RetryableException;
import inpt.lms.messagerie.business.interfaces.MessagerieService;
import inpt.lms.messagerie.business.interfaces.exceptions.NotFoundException;
import inpt.lms.messagerie.forms.MessageForm;
import inpt.lms.messagerie.model.Discussion;
import inpt.lms.messagerie.model.Message;
import inpt.lms.messagerie.proxies.GestionCompteProxyService;
import inpt.lms.messagerie.proxies.ProxyUnavailableException;

@RestController
@RequestMapping(path="/messagerie",
				produces = MediaType.APPLICATION_JSON_VALUE)
public class MessagerieController {
	@Autowired
	protected MessagerieService messagerieService;
	@Autowired
	protected GestionCompteProxyService compteService;
	
	@GetMapping("infos")
	public Page<Discussion> getDiscussions(
			@RequestHeader(name = "X-USER-ID") long userId, Pageable pagination){
		return messagerieService.getDiscussionsUtilisateur(userId, pagination);
	}
	
	@GetMapping("infos/new")
	public List<String> getAllNewDiscussions(
			@RequestHeader(name = "X-USER-ID") long userId){
		return messagerieService.getDiscussionsWithNewMessages(userId);
	}
	
	@GetMapping("discussion/{discId}")
	public Page<Message> getDiscussionMessages(@PathVariable String discId,
			@RequestParam long userId, Pageable pagination) throws NotFoundException{
		return messagerieService.getDiscussionMessages(discId,userId, pagination);
	}
	
	@GetMapping("discussion/{discId}/new")
	public Page<Message> getDiscussionNewMessages(@PathVariable String discId,
			@RequestHeader(name = "X-USER-ID") long userId, Pageable pagination) 
					throws NotFoundException{
		return messagerieService.getDiscussionNewMessages(discId,userId,pagination);
	}
	
	@PostMapping(path="/discussion",consumes=MediaType.APPLICATION_JSON_VALUE)
	public void envoyerMessage(@RequestHeader(name = "X-USER-ID") long userId,
			@Valid @RequestBody  MessageForm messageForm) 
					throws ProxyUnavailableException{
		try {
			compteService.userExists(userId);
		} catch (RetryableException e) {
			throw new ProxyUnavailableException();
		}
		
		Message message = new Message();
		message.setIdEmetteur(userId);
		message.setIdDestinataire(messageForm.getIdDestinataire());
		message.setContenu(messageForm.getContenu());
		messagerieService.envoyerMessage(message);
	}

	public MessagerieService getMessagerieService() {
		return messagerieService;
	}

	public void setMessagerieService(MessagerieService messagerieService) {
		this.messagerieService = messagerieService;
	}
	
	
}
