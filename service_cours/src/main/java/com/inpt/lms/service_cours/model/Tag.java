package com.inpt.lms.service_cours.model;

import java.util.UUID;

import javax.persistence.Entity;
import javax.persistence.Id;
@Entity
public class Tag {
	@Id
	private UUID tagID;
	private String name ;
	
}