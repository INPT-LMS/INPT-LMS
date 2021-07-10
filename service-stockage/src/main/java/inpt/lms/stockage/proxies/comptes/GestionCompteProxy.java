package inpt.lms.stockage.proxies.comptes;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "gestioncompte",url = "${inpt.lms.url.service.gestioncompte}")
public interface GestionCompteProxy {
	
	@GetMapping("/user/{id}")
	public UserWrapper getUserInfos(@PathVariable long id);
}
