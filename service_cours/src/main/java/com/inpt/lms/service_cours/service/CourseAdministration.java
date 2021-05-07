package com.inpt.lms.service_cours.service;

import com.inpt.lms.service_cours.model.Course;
import com.inpt.lms.service_cours.model.Member;

import java.util.ArrayList;
import java.util.UUID;

public interface CourseAdministration {
    public Course createCourse(Course course, UUID ownerID);
    public Course updateCourse(Course course );
    public boolean deleteCourse(UUID courseID);
    public boolean addMembers(UUID courseID, ArrayList<UUID> memberIDs);
    public String retrieveMembers(UUID courseID , ArrayList<UUID> memberIDs);


}
