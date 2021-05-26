package com.inpt.lms.service_cours.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.io.Serializable;
import java.util.*;

import javax.persistence.*;

@Entity
public class Member implements Serializable {
	@Id
	private long memberID ;
	@ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinTable(
			joinColumns = @JoinColumn(name = "memberID"),
			inverseJoinColumns = @JoinColumn(name = "courseID"))
	@JsonIgnore
	private Set<Course> courses = new HashSet<>();
	public Member(long memberID) {
		super();
	}


	public Member() {

	}

	public long getMemberID() {
		return memberID;
	}

	public Set<Course> getCourses() {
		return courses;
	}

	public void setCourses(Set<Course> courses) {
		this.courses = courses;
	}

	public void setMemberID(long memberID) {
		this.memberID = memberID;
	}


}
