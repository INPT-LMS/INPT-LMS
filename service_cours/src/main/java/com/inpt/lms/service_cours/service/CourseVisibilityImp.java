package com.inpt.lms.service_cours.service;

import com.inpt.lms.service_cours.model.Course;
import com.inpt.lms.service_cours.model.Member;
import com.inpt.lms.service_cours.model.Visibility;
import com.inpt.lms.service_cours.repository.CourseInterface;
import com.inpt.lms.service_cours.repository.MemberInterface;
import com.inpt.lms.service_cours.repository.VisibilityInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.*;

@Service
public class CourseVisibilityImp implements CourseVisibility{
    @Autowired
    VisibilityInterface visibilityInterface;
    @Autowired
    CourseInterface  courseInterface ;
    @Autowired
    MemberInterface memberInterface ;
    ArrayList<String> visibilitiess= new ArrayList<>(Arrays.asList("PUBLIC","CODE_ACCESS","PRIVATE"));
     @PostConstruct
    public void setupVisibilities(){
        for(int i = 0 ; i<visibilitiess.size() ; i++){
            Optional<Visibility> visibility = visibilityInterface.findById(i);
            if(!visibility.isPresent()){
                Visibility visibility1 = new Visibility(i,visibilitiess.get(i));
                visibilityInterface.save(visibility1);
            }
        }
    }
    @Override
    public Visibility getCourseVisibility(UUID courseID) {
        return courseInterface.findById(courseID).get().getVisibility();
    }

    @Override
    public List<Course> getPublicCourses(Visibility v) {

        return  null;
    }

    @Override
    public Course getCourseByID(UUID courseID,long userID) {
         Optional<Course> optionalCourse = courseInterface.findById(courseID);
         Optional<Member> optionalMember = memberInterface.findById(userID);
         if(!optionalCourse.isPresent() || !optionalMember.isPresent() ||
                 ! optionalCourse.get().getStudents().contains(optionalMember.get()) ){
             return null;
         }
        return optionalCourse.get();
    }
    @Override
    public Course getPublicCourseByID(UUID courseID) {
        Optional<Course> optionalCourse = courseInterface.findById(courseID);
        if(!optionalCourse.isPresent()  ){
            return null;
        }
        return optionalCourse.get();
    }


    @Override
    public Visibility setCourseVisibility(UUID courseID, int visibilityID) {
        Optional<Course> optionalCourse = courseInterface.findById(courseID);
        if(optionalCourse.isPresent()){
            Optional<Visibility> v = visibilityInterface.findById(visibilityID);
            if(v.isPresent()){
                Course course = optionalCourse.get();
                if(visibilityInterface.findById(v.get().getVisibilityID()).isPresent()){
                    course.setVisibility(v.get());
                    courseInterface.save(course);
            }

            }
        }
        return null;
    }
}
