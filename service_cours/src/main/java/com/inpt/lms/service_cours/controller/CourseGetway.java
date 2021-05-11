package com.inpt.lms.service_cours.controller;

import com.inpt.lms.service_cours.model.Course;
import com.inpt.lms.service_cours.service.CourseAdminImp;
import com.inpt.lms.service_cours.service.CourseDetailsImp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.io.Serializable;
import java.util.List;
import java.util.UUID;


@RestController
public class CourseGetway {
	@Autowired
	CourseAdminImp courseAdminImp ;
	@Autowired
	CourseDetailsImp courseDetailsImp;

	@GetMapping("/courses/owner/{ownerid}")
	public List<Course> getProfessorCourses(@PathVariable long ownerid) {
		//TODO verify authorization

		return courseDetailsImp.getProfessorCourses(ownerid);
	}
	@PostMapping("/course/owner/")
	public Course addCourse(@RequestBody Course course, @RequestHeader("X-USER-ID") long ownerid){
		return courseAdminImp.createCourse(course,ownerid);
	}
	@DeleteMapping("/course/{courseid}")
	public boolean deleteCourse(@PathVariable UUID courseid , @RequestHeader("X-USER-ID") long userid){
		if(courseDetailsImp.isProfessor(courseid,userid)){
			return courseAdminImp.deleteCourse(courseid);
		}
		return false;
	}
	@GetMapping("/course/{courseid}/owner")
	public Serializable getCourseProfessor(@PathVariable UUID courseid , @RequestHeader("X-USER-ID") long userid){
		if(courseDetailsImp.isMember(courseid,userid)){
			return courseDetailsImp.getCourseProfessor(courseid);
		}
		return HttpStatus.UNAUTHORIZED ;
	}
	@GetMapping("/course/{courseid}/owner/{ownerid}")
	public boolean checkProfessor(@PathVariable UUID courseid,@PathVariable long ownerid){
		//TODO verify if member
		return courseDetailsImp.isProfessor(courseid,ownerid);
	}



	
}
