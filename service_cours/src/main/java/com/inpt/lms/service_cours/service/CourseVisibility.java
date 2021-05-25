package com.inpt.lms.service_cours.service;

import com.inpt.lms.service_cours.model.Course;
import com.inpt.lms.service_cours.model.Visibility;

import java.util.List;
import java.util.UUID;

public interface CourseVisibility {
    public Visibility getCourseVisibility(UUID courseID);
    public List<Course> getPublicCourses(Visibility v);
    public Course getCourseByID(UUID courseID,long userID);
    public Visibility setCourseVisibility(UUID courseID , int  visibilityID);
}
