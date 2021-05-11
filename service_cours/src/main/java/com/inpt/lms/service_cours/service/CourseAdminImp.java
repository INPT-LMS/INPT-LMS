package com.inpt.lms.service_cours.service;

import com.inpt.lms.service_cours.model.Course;
import com.inpt.lms.service_cours.model.Member;
import com.inpt.lms.service_cours.model.Professor;
import com.inpt.lms.service_cours.repository.CourseInterface;
import com.inpt.lms.service_cours.repository.MemberInterface;
import com.inpt.lms.service_cours.repository.ProfessorInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class CourseAdminImp implements CourseAdministration{
    @Autowired
    CourseInterface courseInterface;
    @Autowired
    ProfessorInterface professorInterface;
    @Autowired
    MemberInterface memberInterface ;
    @Override
    public Course createCourse(Course course, long ownerID) {
        Professor creator = professorInterface.findById(ownerID).orElse(new Professor(ownerID));
        course.setOwner(creator);
        professorInterface.save(creator);
        courseInterface.save(course);
        return course;

    }



    @Override
    public boolean deleteCourse(UUID courseID) {
       Optional<Course> course = courseInterface.findById(courseID);
       if(course.isPresent()){
           Course courseInstance = course.get();
           Professor professor = courseInstance.getOwner();
           List<Course> coursesList = professor.getOwnedCourses();
           coursesList.remove(courseInstance);
           professor.setOwnedCourses(coursesList);
           courseInterface.deleteById(courseInstance.getCourseID());
           professorInterface.save(professor);
           return  true;


       }
       return false ;


    }

    @Override
    public boolean addMember(UUID courseID, long memberID,long ownerID) {
        Optional<Member> member = memberInterface.findById(memberID);
        Member member1 = new Member();
        if(!member.isPresent()){
            member1.setMemberID(memberID);
        }
        else {
            member1 = member.get();
        }
        Optional<Course> course = courseInterface.findById(courseID);
        if(course.isPresent()){
            Course course1 = course.get();
            List<Course> memberCourses = member1.getCourses();
            if(memberCourses.contains(course1)){
                return true ;
            }
            if( course1.getOwner().equals(professorInterface.findById(ownerID).orElse(null)) || course1.getVisibility().getVisibilityID() == 0){
                memberCourses.add(course1);
                member1.setCourses(memberCourses);
                course1.getStudents().add(member1);
                memberInterface.save(member1);
                courseInterface.save(course1);
                return true ;
            }
        }
        return false;
    }

    @Override
    public String retrieveMember(UUID courseID, long memberID) {
        Member member = memberInterface.findById(memberID).orElse(new Member(memberID));

        Optional<Course> course = courseInterface.findById(courseID);
        if(course.isPresent()){
            Course course1 = course.get();
            List<Course> memberCourses = member.getCourses();
            if(memberCourses.contains(course1)){
               memberCourses.remove(course1);
            }


            course1.getStudents().remove(member);

            memberInterface.save(member);
            courseInterface.save(course1);
            return "DELETED" ;
        }
        return "NOT DELETED";
    }


}
