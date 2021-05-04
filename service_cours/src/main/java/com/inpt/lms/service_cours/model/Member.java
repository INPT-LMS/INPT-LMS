package com.inpt.lms.service_cours.model;

import java.io.Serializable;
import java.util.List;
import java.util.UUID;

import javax.persistence.Entity;
import javax.persistence.Id;
@Entity
public class Member implements Serializable {
	@Id
	private UUID memberID ;
	//private List<Course> courses;
	public Member() {
		super();
	}
	

}
