package com.lms.servicepublications.beans;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CoursBean {
    private UUID courseID = UUID.randomUUID();
    private String courseName;
    private String courseDescription ;
    private String imageURL ;

}
