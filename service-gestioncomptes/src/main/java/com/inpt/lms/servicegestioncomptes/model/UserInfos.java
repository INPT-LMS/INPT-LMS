package com.inpt.lms.servicegestioncomptes.model;


import lombok.Data;
import lombok.ToString;

import javax.persistence.*;

@Entity
@Table
@Data
@ToString
public class UserInfos {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Transient
    @OneToOne(fetch = FetchType.EAGER,cascade = CascadeType.ALL,mappedBy ="userInfos" )
    private User user;

    private String nom;
    private String prenom;
    private boolean estProfesseur;
    private String enseigneA;
    private String etudieA;
    private String langue;
}
