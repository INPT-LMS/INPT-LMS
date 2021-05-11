package com.inpt.lms.service_cours.service;

import com.inpt.lms.service_cours.model.Course;
import com.inpt.lms.service_cours.model.Member;
import com.inpt.lms.service_cours.model.Visibility;

import java.util.List;
import java.util.UUID;

public interface CourseDatails {
    public List<Member> getCourseMembers(UUID courseID);
    public List<Course> getStudentCourses(long studentID);
    public List<Course> getProfessorCourses(long professorID);
    public boolean isProfessor(UUID courseID, long professorID);
    public boolean isMember(UUID courseID, long userID);
    public long getCourseProfessor(UUID courseID);
    public List<Member> getBannedStudents(UUID courseID);

}
