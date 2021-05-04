package com.inpt.lms.service_cours.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Visibility implements Serializable{
	@Id
	private int visibilityID;
	private String name ;
	
	public Visibility() {
		super();
	}

	public int getVisibilityID() {
		return visibilityID;
	}

	public void setVisibilityID(int visibilityID) {
		this.visibilityID = visibilityID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
}
