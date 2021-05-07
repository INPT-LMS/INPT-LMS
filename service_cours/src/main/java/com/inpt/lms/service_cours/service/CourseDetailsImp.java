package com.inpt.lms.service_cours.service;

import com.inpt.lms.service_cours.model.Course;
import com.inpt.lms.service_cours.model.Member;
import com.inpt.lms.service_cours.model.Professor;
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
    @Override
    public List<Course> getStudentCourses(UUID studentID) {
        return null;
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
    public boolean isProfessor(UUID courseID) {
        return false;
    }

    @Override
    public List<Member> getCourseMembers(UUID courseID) {
        return null;
    }

    @Override
    public UUID getCourseProfessor(UUID courseID) {
        return null;
    }

    @Override
    public List<Member> getBannedStudents(UUID courseID) {
        return null;
    }
}
