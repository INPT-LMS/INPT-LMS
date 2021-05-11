package inpt.lms.stockage.proxies.publication;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "publication",url = "${inpt.lms.url.service.publication}")
public interface GestionPublicationProxy {
	@GetMapping("/publications/{idPublication}")
    public Publication getPublication(@PathVariable String idPublication);
}
