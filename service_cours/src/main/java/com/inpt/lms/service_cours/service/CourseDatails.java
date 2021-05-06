package com.inpt.lms.service_cours.service;

import com.inpt.lms.service_cours.model.Course;
import com.inpt.lms.service_cours.model.Member;
import com.inpt.lms.service_cours.model.Visibility;

import java.util.List;
import java.util.UUID;

public interface CourseDatails {
    public List<Course> getStudentCourses(UUID studentID);
    public List<Course> getProfessorCourses(UUID professorID);
    public boolean isProfessor(UUID courseID);
    public List<Member> getCourseMembers(UUID courseID);
    public UUID getCourseProfessor(UUID courseID);
    public List<Member> getBannedStudents(UUID courseID);



}
