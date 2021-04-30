package com.inpt.lms.servicegestioncomptes.model;

import lombok.Data;

import javax.persistence.*;

@Entity
@Table
@Data
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JoinColumn(name="user_infos_id")
    private UserInfos userInfos;

    private String email;
    private String password;
}
