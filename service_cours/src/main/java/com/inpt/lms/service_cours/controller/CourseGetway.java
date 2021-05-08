package com.inpt.lms.service_cours.controller;

import com.inpt.lms.service_cours.model.Course;
import com.inpt.lms.service_cours.model.Member;
import com.inpt.lms.service_cours.service.CourseAdminImp;
import com.inpt.lms.service_cours.service.CourseDetailsImp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;
import java.util.UUID;


@RestController
public class CourseGetway {
	@Autowired
	CourseAdminImp courseAdminImp ;
	@Autowired
	CourseDetailsImp courseDetailsImp;

	@GetMapping("/courses/owner/{ownerid}")
	public List<Course> getProfessorCourses(@PathVariable UUID ownerid) {
		//TODO verify if professor
		return courseDetailsImp.getProfessorCourses(ownerid);
	}
	@PostMapping("/course/owner/")
	public Course addCourse(@RequestBody Course course, @RequestHeader("X-USER-ID") UUID ownerid){
		Course addedCours = courseAdminImp.createCourse(course,ownerid);
		return addedCours;
	}
	@DeleteMapping("/course/{courseid}")
	public boolean deleteCourse(@PathVariable UUID courseid){
		//TODO verify if professor
		return courseAdminImp.deleteCourse(courseid);
	}
	@GetMapping("/course/{courseid}/owner")
	public UUID getCourseProfessor(@PathVariable UUID courseid){
		//TODO verify if member
		return courseDetailsImp.getCourseProfessor(courseid);
	}
	@GetMapping("/course/{courseid}/owner/{ownerid}")
	public boolean checkProfessor(@PathVariable UUID courseid,@PathVariable UUID ownerid){
		//TODO verify if member
		return courseDetailsImp.isProfessor(courseid,ownerid);
	}



	
}
