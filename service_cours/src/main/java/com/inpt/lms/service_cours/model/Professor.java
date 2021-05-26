package com.inpt.lms.service_cours.model;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
@Entity
public class Professor implements Serializable{
	@Id
	private long professorID ;
	@OneToMany(mappedBy = "owner", fetch = FetchType.LAZY,
            cascade = CascadeType.ALL)
	
	private List<Course> ownedCourses;
	public Professor(@JsonProperty long professorID){
		this.professorID = professorID;
	}


	public Professor() {

	}

	public long getProfessorID() {
		return professorID;
	}

	public void setProfessorID(long professorID) {
		this.professorID = professorID;
	}

	public List<Course> getOwnedCourses() {
		return ownedCourses== null ? new ArrayList<>() : ownedCourses;
	}

	public void setOwnedCourses(List<Course> ownedCourses) {
		this.ownedCourses = ownedCourses;
	}
}
