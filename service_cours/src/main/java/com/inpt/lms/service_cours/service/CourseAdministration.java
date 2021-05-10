package com.inpt.lms.service_cours.service;

import com.inpt.lms.service_cours.model.Course;

import java.util.UUID;

public interface CourseAdministration {
    public Course createCourse(Course course, long ownerID);

    public boolean deleteCourse(UUID courseID);
    public boolean addMember(UUID courseID, long memberID, long ownerID);
    public String retrieveMember(UUID courseID ,long memberID);


}
