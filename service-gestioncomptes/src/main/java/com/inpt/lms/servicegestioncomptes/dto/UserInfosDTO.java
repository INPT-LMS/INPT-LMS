package com.inpt.lms.servicegestioncomptes.dto;

import lombok.Data;

@Data
public class UserInfosDTO {
    private String email;
    private String password;
    private String nom;
    private String prenom;
    private boolean estProfesseur;
    private String enseigneA;
    private String etudieA;
    private String langue;
}

