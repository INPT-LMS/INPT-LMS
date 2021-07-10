package com.inpt.lms.service_cours.service;

import com.inpt.lms.service_cours.model.Course;

import java.util.List;
import java.util.Set;

public interface StudentService {
    public Set<Course> getStudentCourses(long ownerID);
}
