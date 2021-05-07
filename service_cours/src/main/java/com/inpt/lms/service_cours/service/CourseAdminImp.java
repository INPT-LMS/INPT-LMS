package com.inpt.lms.service_cours.service;

import com.inpt.lms.service_cours.model.Course;
import com.inpt.lms.service_cours.model.Professor;
import com.inpt.lms.service_cours.repository.CourseInterface;
import com.inpt.lms.service_cours.repository.ProfessorInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class CourseAdminImp implements CourseAdministration{
    @Autowired
    CourseInterface courseInterface;
    @Autowired
    ProfessorInterface professorInterface;

    @Override
    public Course createCourse(Course course, UUID ownerID) {
        Professor creator = professorInterface.findById(ownerID).orElse(new Professor(ownerID));
        course.setOwner(creator);
        professorInterface.save(creator);
        courseInterface.save(course);


        return course;

    }

    @Override
    public Course updateCourse(Course course) {
        return null;
    }

    @Override
    public boolean deleteCourse(UUID courseID) {
       Optional<Course> course = courseInterface.findById(courseID);
       if(course.isPresent()){
           Course courseInstance = course.get();
           Professor professor = courseInstance.getOwner();
           List coursesList = professor.getOwnedCourses();
           coursesList.remove(courseInstance);
           professor.setOwnedCourses(coursesList);
           courseInterface.deleteById(courseInstance.getCourseID());
           professorInterface.save(professor);
           return  true;


       }
       return false ;


    }

    @Override
    public boolean addMembers(UUID courseID, ArrayList<UUID> memberIDs) {
        return false;
    }

    @Override
    public String retrieveMembers(UUID courseID, ArrayList<UUID> memberIDs) {
        return null;
    }
}
