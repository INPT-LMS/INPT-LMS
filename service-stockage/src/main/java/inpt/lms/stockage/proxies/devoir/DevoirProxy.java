package inpt.lms.stockage.proxies.devoir;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;

@FeignClient(name = "devoir",url = "${inpt.lms.url.service.devoir}")
public interface DevoirProxy {
	@GetMapping("/devoirs/{courseId}/{devoirId}")
	   public Devoir getDevoir(@RequestHeader(name = "X-USER-ID") Long userId,
			   @PathVariable String courseId, @PathVariable String devoirId);
}
