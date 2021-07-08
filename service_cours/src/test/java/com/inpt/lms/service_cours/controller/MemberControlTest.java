package com.inpt.lms.service_cours.controller;

import com.inpt.lms.service_cours.model.Course;
import com.inpt.lms.service_cours.model.Member;
import com.inpt.lms.service_cours.model.Visibility;
import com.inpt.lms.service_cours.repository.VisibilityInterface;
import com.inpt.lms.service_cours.service.CourseAdminImp;
import com.inpt.lms.service_cours.service.CourseVisibility;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
@Transactional
class MemberControlTest {
    UUID COURSEID = UUID.randomUUID();
    long professorID = 500;
    long memberID = 3;
    @Autowired
    CourseAdminImp courseAdminImp ;
    @Autowired
    CourseVisibility courseVisibility ;
    @Test
    void addCourse() {
        Course course = new Course();
        course.setCourseName("course to test");
        course.setCourseID(COURSEID);
        Course expectedCourse = courseAdminImp.createCourse(course,professorID);
        assertThat(expectedCourse.getCourseName()).isEqualTo("course to test");
    }
    @Test
    void addPrivateCourse() {
        Course course = new Course();
        course.setCourseName("private course to test");
        course.setCourseID(COURSEID);
        Course expectedCourse = courseAdminImp.createCourse(course,professorID);
        courseVisibility.setCourseVisibility(COURSEID,2);
        assertThat(expectedCourse.getCourseName()).isEqualTo("private course to test");

    }
    @Test
    void addMember() {
        addCourse();
        assertThat(courseAdminImp.addMember(COURSEID,memberID,professorID)).isTrue();
        assertThat(courseAdminImp.addMember(COURSEID,memberID,2)).isTrue();
    }
    @Test
    void AddMemberToPrivateCourse(){
        addPrivateCourse();
        assertThat(courseAdminImp.addMember(COURSEID,memberID,professorID)).isTrue();
        assertThat(courseAdminImp.addMember(COURSEID,1,2)).isFalse();
    }
    @Test
    void getPublicCourse(){
        addCourse();
        assertThat(courseVisibility.getPublicCourseByID(COURSEID).getCourseName().equals("course to test"));

    }
    @Test
    void getCourse(){
        addMember();
        assertThat(courseVisibility.getCourseByID(COURSEID,memberID).getCourseName().equals("UNAUTHORIZED"));
    }

    @Test
    void getCourseMembers() {

    }

    @Test
    void retreiveMember() {
    }
}