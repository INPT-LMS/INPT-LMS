package com.inpt.lms.service_cours.service;

import com.inpt.lms.service_cours.model.Course;
import com.inpt.lms.service_cours.model.Member;
import com.inpt.lms.service_cours.repository.MemberInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class StudentServiceImp implements StudentService{
    @Autowired
    MemberInterface memberInterface ;
    @Override
    public List<Course> getStudentCourses(long ownerID) {
        Optional<Member> memberOptional = memberInterface.findById(ownerID);
        return memberOptional.map(Member::getCourses).orElse(null);
    }
}
