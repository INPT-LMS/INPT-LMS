package com.inpt.lms.service_cours.repository;

import java.util.List;
import java.util.UUID;

import com.inpt.lms.service_cours.model.Visibility;
import org.springframework.data.jpa.repository.JpaRepository;

import com.inpt.lms.service_cours.model.Course;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CourseInterface extends JpaRepository<Course,UUID> {
    public List<Course> getCourseByCourseNameContainingAndVisibilityVisibilityID(String course,int v);
}
