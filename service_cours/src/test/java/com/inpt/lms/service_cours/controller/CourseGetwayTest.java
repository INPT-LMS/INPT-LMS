package com.inpt.lms.service_cours.controller;

import com.inpt.lms.service_cours.model.Course;
import com.inpt.lms.service_cours.model.Member;
import com.inpt.lms.service_cours.service.CourseAdminImp;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;

@SpringBootTest
@Transactional
class CourseGetwayTest {
    UUID COURSEID = UUID.randomUUID();
    long professorID = 500;
    long memberID = 3;
    @Autowired
    CourseAdminImp courseAdminImp ;
    @Test
    void addCourse() {
        Course course = new Course();
        course.setCourseName("course to test");
        course.setCourseID(COURSEID);
        Course expectedCourse = courseAdminImp.createCourse(course,professorID);
        assertThat(expectedCourse.getCourseName()).isEqualTo("course to test");
    }
    @Test
    void addMember() {
       addCourse();
       assertThat(courseAdminImp.addMember(COURSEID,memberID,professorID)).isTrue();
    }






}