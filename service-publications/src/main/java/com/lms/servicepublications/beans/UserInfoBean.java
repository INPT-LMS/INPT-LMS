package com.lms.servicepublications.beans;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class UserInfoBean {
    private String nom;
    private String prenom;
    private boolean estProfesseur;
    private String enseigneA;
    private String etudieA;
    private String langue;
}
