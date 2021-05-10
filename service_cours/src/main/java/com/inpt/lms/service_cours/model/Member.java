package com.inpt.lms.service_cours.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.io.Serializable;
import java.util.ArrayList;
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
	private long memberID = 0 ;
	@ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	 @JoinTable
	@JsonIgnore
	private List<Course> courses = new ArrayList<>();
	public Member(long memberID) {
		super();
	}


	public Member() {

	}

	public long getMemberID() {
		return memberID;
	}

	public void setMemberID(long memberID) {
		this.memberID = memberID;
	}

	public List<Course> getCourses() {
		return courses;
	}

	public void setCourses(List<Course> courses) {
		this.courses = courses;
	}
}
