package inpt.lms.stockage.proxies;

import java.util.List;
import java.util.UUID;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "cours",url = "${inpt.lms.url.service.cours}")
public interface GestionCoursProxy {
	
	@GetMapping("/course/{courseID}/members")
    public List<Member> getCourseMembers(@PathVariable UUID courseID);
	
	@GetMapping("/course/{courseid}/owner/{ownerid}")
	public boolean checkProfessor(@PathVariable UUID courseid,@PathVariable UUID ownerid);

}
