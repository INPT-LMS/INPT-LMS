package inpt.lms.messagerie.proxies;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "gestioncompte",url = "${inpt.lms.url.service.gestioncompte}")
public interface GestionCompteProxyService {
	
	@GetMapping("/user/{id}")
	public UserWrapper getUserInfos(@PathVariable long id);
}
