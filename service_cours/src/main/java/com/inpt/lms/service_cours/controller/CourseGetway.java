package com.inpt.lms.service_cours.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class CourseGetway {
	@GetMapping("/courses")
	public String getCourses() {
		return "courses";
	}
	
}
