package com.inpt.lms.service_cours.service;

import com.inpt.lms.service_cours.model.Course;

import java.util.List;

public interface StudentService {
    public List<Course> getStudentCourses(long ownerID);
}
