package com.inpt.lms.service_cours.controller;

import com.inpt.lms.service_cours.model.Course;
import com.inpt.lms.service_cours.model.Member;
import com.inpt.lms.service_cours.service.CourseAdministration;
import com.inpt.lms.service_cours.service.CourseDatails;
import com.inpt.lms.service_cours.service.CourseDetailsImp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
public class MemberControl {
    @Autowired
    CourseDatails courseDetails;
    @Autowired
    CourseAdministration courseAdministration;

    @PostMapping("/course/{courseID}/member/{memberID}")
    public boolean addMember(@PathVariable UUID courseID, @PathVariable UUID memberID){
        return courseAdministration.addMember(courseID,memberID);

    }
    @GetMapping("/course/{courseID}/members")
    public List<Member> getCourseMembers(@PathVariable UUID courseID){
        return courseDetails.getCourseMembers(courseID);
    }
    @DeleteMapping("/course/{courseID}/member/{memberID}")
    public String retreiveMember(@PathVariable UUID courseID, @PathVariable UUID memberID){
        return courseAdministration.retrieveMember(courseID,memberID);
    }
}
