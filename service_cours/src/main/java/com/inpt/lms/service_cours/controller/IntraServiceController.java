package com.inpt.lms.service_cours.controller;

import com.inpt.lms.service_cours.model.Member;
import com.inpt.lms.service_cours.service.CourseDatails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RequestMapping("/admin/")
@RestController
public class IntraServiceController {
    @Autowired
    CourseDatails courseDetails;
    @GetMapping("/course/{courseID}/members")
    public List<Member> getCourseMembers(@PathVariable UUID courseID){
        return courseDetails.getCourseMembers(courseID);
    }
}
