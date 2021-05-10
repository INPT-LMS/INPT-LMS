package com.inpt.lms.service_cours.service;

import com.inpt.lms.service_cours.model.Course;
import com.inpt.lms.service_cours.model.Member;
import com.inpt.lms.service_cours.model.Professor;
import com.inpt.lms.service_cours.repository.CourseInterface;
import com.inpt.lms.service_cours.repository.MemberInterface;
import com.inpt.lms.service_cours.repository.ProfessorInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
@Service
public class CourseDetailsImp implements CourseDatails{
    @Autowired
    ProfessorInterface professorInterface;
    @Autowired
    MemberInterface memberInterface;
    @Autowired
    CourseInterface courseInterface ;
    @Override
    public List<Course> getStudentCourses(UUID studentID) {
        Optional<Member> memberOptional = memberInterface.findById(studentID);
        if(memberOptional.isPresent()){
            return memberOptional.get().getCourses();
        }
        return new ArrayList<>();
    }

    @Override
    public List<Course> getProfessorCourses(UUID professorID) {
        Optional<Professor> owner = professorInterface.findById(professorID);
        if(owner.isPresent()){
            return owner.get().getOwnedCourses();
        }
        return new ArrayList<>();
    }

    @Override
    public boolean isProfessor(UUID courseID, UUID professorID) {
        Optional<Course> optionalCourse = courseInterface.findById(courseID);
        if(optionalCourse.isPresent()){
            if(optionalCourse.get().getOwner().getProfessorID().equals(professorID)){
                return true;
            }
        }
        return false;
    }

    @Override
    public boolean isMember(UUID courseID, UUID userID) {
        Optional<Course> courseOptional = courseInterface.findById(courseID);
        if(courseOptional.isPresent()){
            Optional<Member> optionalMember = memberInterface.findById(userID);
            if(optionalMember.isPresent()){
                Member member = optionalMember.get();
                if(member.getCourses().contains(courseOptional.get())){
                    return true ;
                }
            }
        }
        return false;
    }

    @Override
    public List<Member> getCourseMembers(UUID courseID) {
        Optional<Course> course = courseInterface.findById(courseID);
        if(course.isPresent()){
            return course.get().getStudents();
        }
        return null ;
    }

    @Override
    public UUID getCourseProfessor(UUID courseID) {
        Optional<Course> courseOptional = courseInterface.findById(courseID);
        if(courseOptional.isPresent()){
            return courseOptional.get().getOwner().getProfessorID();
        }
        return null;
    }

    @Override
    public List<Member> getBannedStudents(UUID courseID) {
        return null;
    }
}