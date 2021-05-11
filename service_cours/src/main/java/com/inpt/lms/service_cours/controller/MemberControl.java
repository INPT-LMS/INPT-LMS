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
    public boolean addMember(@PathVariable UUID courseID, @PathVariable long memberID,
                             @RequestHeader("X-USER-ID") long userid){

        return courseAdministration.addMember(courseID,memberID,userid);

    }
    @GetMapping("/course/{courseID}/members")
    public List<Member> getCourseMembers(@PathVariable UUID courseID){
        //TODO verify if professor or member or course public
        return courseDetails.getCourseMembers(courseID);
    }
    @DeleteMapping("/course/{courseID}/member/{memberID}")
    public String retreiveMember(@PathVariable UUID courseID, @PathVariable long memberID ,
                                 @RequestHeader("X-USER-ID") long userid){
        if(courseDetails.isProfessor(courseID,userid)){
            return courseAdministration.retrieveMember(courseID,memberID);
        }

        return null;
    }
}
