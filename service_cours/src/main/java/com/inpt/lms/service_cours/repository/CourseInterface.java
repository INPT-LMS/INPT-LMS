package com.inpt.lms.service_cours.repository;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import com.inpt.lms.service_cours.model.Course;

public interface CourseInterface extends JpaRepository<Course,UUID>{

}
