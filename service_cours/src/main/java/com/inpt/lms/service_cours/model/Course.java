package com.inpt.lms.service_cours.model;

import java.io.Serializable;
import java.util.List;
import java.util.UUID;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
@Entity
public class Course implements Serializable{
	@Id
	private UUID courseID;
	private String courseName;
	private String courseDescription ;
	private String imageURL ;
	 @ManyToOne(fetch = FetchType.LAZY, optional = false)
	 @JoinColumn(name = "professorid", nullable = false)
	private Professor owner ;
	 @ManyToMany(mappedBy="courses" , fetch = FetchType.LAZY)
	private List<Member> students;
	
	private Visibility visibility;
	public Course() {
		super();
	}
	public Course( String courseName, String courseDescription, String imageURL) {
		super();
		this.courseID = UUID.randomUUID();
		this.courseName = courseName;
		this.courseDescription = courseDescription;
		this.imageURL = imageURL;
	}
	public UUID getCourseID() {
		return courseID;
	}
	public void setCourseID(UUID courseID) {
		this.courseID = courseID;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public String getCourseDescription() {
		return courseDescription;
	}
	public void setCourseDescription(String courseDescription) {
		this.courseDescription = courseDescription;
	}
	public String getImageURL() {
		return imageURL;
	}
	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}
	
	
}
