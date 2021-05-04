package com.inpt.lms.service_cours.model;

import java.io.Serializable;
import java.util.List;
import java.util.UUID;

import javax.persistence.Entity;
import javax.persistence.Id;
@Entity
public class Professor implements Serializable{
	@Id
	private UUID professorID ;
	//private List<Course> ownedCourses;
	
}
