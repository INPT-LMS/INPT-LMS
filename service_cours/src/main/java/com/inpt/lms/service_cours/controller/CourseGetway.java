package com.inpt.lms.service_cours.controller;

import com.inpt.lms.service_cours.model.Course;
import com.inpt.lms.service_cours.service.CourseAdminImp;
import com.inpt.lms.service_cours.service.CourseDetailsImp;
import com.inpt.lms.service_cours.service.CourseVisibility;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.io.Serializable;
import java.util.List;
import java.util.UUID;

@RequestMapping("/public/")
@RestController
public class CourseGetway {
	@Autowired
	CourseAdminImp courseAdminImp ;
	@Autowired
	CourseDetailsImp courseDetailsImp;
	@Autowired
	CourseVisibility courseVisibility ;
	@GetMapping("/courses/owner")
	public List<Course> getProfessorCourses( @RequestHeader("X-USER-ID") long ownerid) {
		return courseDetailsImp.getProfessorCourses(ownerid);
	}
	@GetMapping("/course/{courseID}")
	public Serializable getCourseByID(@PathVariable UUID courseID, @RequestHeader("X-USER-ID") long userID) {
		if(courseDetailsImp.isMember(courseID,userID)){
			return courseVisibility.getCourseByID(courseID,userID);
		}
		return HttpStatus.UNAUTHORIZED;
	}
	@PostMapping("/course/owner")
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

	@GetMapping("/course/discover/{courseName}")
	public List<Course> getCoursesByName(@PathVariable String courseName){
		return courseDetailsImp.getCoursesByName(courseName,1);
	}
	/* @GetMapping("/course/{courseid}/owner/{ownerid}")
	public boolean checkProfessor(@PathVariable UUID courseid,@PathVariable long ownerid){

		return courseDetailsImp.isProfessor(courseid,ownerid);
	} */



	
}
