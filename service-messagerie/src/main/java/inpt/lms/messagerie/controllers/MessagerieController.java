package inpt.lms.messagerie.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import inpt.lms.messagerie.business.interfaces.MessagerieService;
import inpt.lms.messagerie.business.interfaces.exceptions.NotFoundException;
import inpt.lms.messagerie.model.Discussion;
import inpt.lms.messagerie.model.Message;

@RestController
@RequestMapping(path="/messagerie",
				produces = MediaType.APPLICATION_JSON_VALUE)
public class MessagerieController {
	@Autowired
	protected MessagerieService messagerieService;
	
	@GetMapping("infos/{userId}")
	public Page<Discussion> getDiscussions(@PathVariable long userId,
			Pageable pagination){
		return messagerieService.getDiscussionsUtilisateur(userId, pagination);
	}
	
	@GetMapping("infos/{userId}/new")
	public List<String> getAllNewDiscussions(@PathVariable long userId){
		return messagerieService.getDiscussionsWithNewMessages(userId);
	}
	
	@GetMapping("discussion/{discId}")
	public Page<Message> getDiscussionMessages(@PathVariable String discId,
			@RequestParam long userId, Pageable pagination) throws NotFoundException{
		return messagerieService.getDiscussionMessages(discId,userId, pagination);
	}
	
	@GetMapping("discussion/{discId}/new")
	public Page<Message> getDiscussionNewMessages(@PathVariable String discId,
			@RequestParam long userId, Pageable pagination) throws NotFoundException{
		return messagerieService.getDiscussionNewMessages(discId,userId,pagination);
	}
	
	@PostMapping(path="/discussion",consumes=MediaType.APPLICATION_JSON_VALUE)
	public void envoyerMessage(@RequestBody Message message){
		messagerieService.envoyerMessage(message);
	}

	public MessagerieService getMessagerieService() {
		return messagerieService;
	}

	public void setMessagerieService(MessagerieService messagerieService) {
		this.messagerieService = messagerieService;
	}
	
	
}
