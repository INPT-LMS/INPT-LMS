package com.inpt.lms.service_cours.controller;

import com.inpt.lms.service_cours.model.Visibility;
import com.inpt.lms.service_cours.service.CourseVisibility;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
public class VisibilityAdmin {
    @Autowired
    CourseVisibility courseVisibility ;
    @GetMapping("/course/{courseid}/visibility")
    public Visibility getCourseVisibility(@PathVariable UUID courseid){
        return courseVisibility.getCourseVisibility(courseid);
    }
    @PutMapping("/course/{courseid}/visibility/{visibilityid}")
    public Visibility setCourseVisibility(@PathVariable UUID courseid,@PathVariable int visibilityid){
        //TODO verify if professor
        return courseVisibility.setCourseVisibility(courseid,visibilityid);
    }

}
