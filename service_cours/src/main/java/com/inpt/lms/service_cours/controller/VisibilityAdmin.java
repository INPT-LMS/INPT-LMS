package com.inpt.lms.service_cours.controller;

import com.inpt.lms.service_cours.model.Course;
import com.inpt.lms.service_cours.model.Visibility;
import com.inpt.lms.service_cours.service.CourseAdminImp;
import com.inpt.lms.service_cours.service.CourseDatails;
import com.inpt.lms.service_cours.service.CourseVisibility;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;
import java.util.UUID;
@RequestMapping("/public")
@RestController
public class VisibilityAdmin {
    @Autowired
    CourseVisibility courseVisibility ;
    @Autowired
    CourseDatails courseDatails ;
    @Autowired
    CourseAdminImp courseAdminImp;
    @GetMapping("/course/{courseid}/visibility")
    public Visibility getCourseVisibility(@PathVariable UUID courseid){
        return courseVisibility.getCourseVisibility(courseid);
    }
    @GetMapping("/courses/all")
    public List<Course> getAllcourses(){
        return courseAdminImp.getAllCourses();
    }
    @PutMapping("/course/{courseid}/visibility/{visibilityid}")
    public Visibility setCourseVisibility(@PathVariable UUID courseid,@PathVariable int visibilityid, @RequestHeader("X-USER-ID") long userid){
        if(courseDatails.isProfessor(courseid,userid)){
            return courseVisibility.setCourseVisibility(courseid,visibilityid);
        }
        return null;
    }

}
