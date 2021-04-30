package com.inpt.lms.servicegestioncomptes.model;


import lombok.Data;

import javax.persistence.*;

@Entity
@Table
@Data
public class UserInfos {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY,cascade = CascadeType.ALL,mappedBy = "userInfos")
    private User user;

    private String nom;
    private String prenom;
    private boolean estProfesseur;
    private String enseigneA;
    private String etudieA;
    private String langue;
}
