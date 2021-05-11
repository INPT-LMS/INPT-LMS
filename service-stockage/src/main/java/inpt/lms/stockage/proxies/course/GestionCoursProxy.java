package inpt.lms.stockage.proxies.course;

import java.util.List;
import java.util.UUID;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;

@FeignClient(name = "cours",url = "${inpt.lms.url.service.cours}")
public interface GestionCoursProxy {
	
	@GetMapping("/admin/course/{courseID}/members")
    public List<Member> getCourseMembers(@PathVariable UUID courseID);
	
	@GetMapping("/public/course/{courseid}/owner")
	public String getCourseProfessor(@PathVariable UUID courseid , @RequestHeader("X-USER-ID") long userid);

}
