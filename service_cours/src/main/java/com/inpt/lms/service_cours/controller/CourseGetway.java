package com.inpt.lms.service_cours.controller;

import com.inpt.lms.service_cours.model.Course;
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
		return courseDetailsImp.getProfessorCourses(ownerid);
	}
	@PostMapping("/course/owner/{ownerid}")
	public Course addCourse(@RequestBody Course course, @PathVariable UUID ownerid){
		Course addedCours = courseAdminImp.createCourse(course,ownerid);
		return addedCours;
	}

	@DeleteMapping("/course/{courseid}")
	public boolean deleteCourse(@PathVariable UUID courseid){
		return courseAdminImp.deleteCourse(courseid);
	}

	
}
