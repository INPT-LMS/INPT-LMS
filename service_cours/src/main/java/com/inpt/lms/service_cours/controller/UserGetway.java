package com.inpt.lms.service_cours.controller;

import com.inpt.lms.service_cours.model.Course;
import com.inpt.lms.service_cours.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/public/")
@RestController
public class UserGetway {
    @Autowired
    StudentService studentService ;
    @GetMapping("/student/courses")
    public List<Course> getStudentCourses(@RequestHeader("X-USER-ID") long userID){
        return studentService.getStudentCourses(userID);

    }
}
