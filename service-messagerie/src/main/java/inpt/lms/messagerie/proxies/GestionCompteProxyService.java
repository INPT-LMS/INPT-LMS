package inpt.lms.messagerie.proxies;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "gestioncompte",url = "${inpt.lms.url.service.gestioncompte}")
public interface GestionCompteProxyService {
	
	// Cette route renvoie des informations sur un utilisateur mais ceci ne nous
	// intéresse pas. Si la méthode se termine correctement alors l'utilisateur 
	// existe
	@GetMapping("/user/{id}")
	public void userExists(@PathVariable long id);
}
