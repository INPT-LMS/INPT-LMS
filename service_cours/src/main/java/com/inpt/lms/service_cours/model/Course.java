package com.inpt.lms.service_cours.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.hibernate.annotations.Type;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.persistence.*;

@Entity
public class Course implements Serializable{
	@Id
	@Type(type="uuid-char")
	@Column( columnDefinition= "VARCHAR(64)")
	private UUID courseID = UUID.randomUUID();
	private String courseName;
	private String courseDescription ;
	private String imageURL ;
	@ManyToOne
	@JoinColumn
	private Visibility visibility = new Visibility() ;
	 @ManyToOne(fetch = FetchType.LAZY, optional = false)
	 @JoinColumn(name = "professorid", nullable = false)
	 @JsonIgnore
	private Professor owner ;
	 @ManyToMany(mappedBy="courses" , fetch = FetchType.LAZY)

	private List<Member> students = new ArrayList<>();

	public Course() {
		super();
	}
	public Course(@JsonProperty String courseName,@JsonProperty String courseDescription,@JsonProperty String imageURL) {
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

	public Professor getOwner() {
		return owner;
	}

	public void setOwner(Professor owner) {
		this.owner = owner;
	}

	public List<Member> getStudents() {
		return students;
	}

	public void setStudents(List<Member> students) {
		this.students = students;
	}

	public Visibility getVisibility() {
		return visibility;
	}

	public void setVisibility(Visibility visibility) {
		this.visibility = visibility;
	}
}
