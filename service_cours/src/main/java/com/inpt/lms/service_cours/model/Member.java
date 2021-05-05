package com.inpt.lms.service_cours.model;

import java.io.Serializable;
import java.util.List;
import java.util.UUID;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
@Entity
public class Member implements Serializable {
	@Id
	private UUID memberID ;
	@ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	 @JoinTable
	private List<Course> courses;
	public Member() {
		super();
	}
	

}
