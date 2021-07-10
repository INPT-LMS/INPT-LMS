package com.inpt.lms.servicegestioncomptes.model;

import lombok.Data;
import lombok.ToString;

import javax.persistence.*;

@Entity
@Table
@Data
@ToString
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.EAGER,cascade = CascadeType.ALL)
    @JoinColumn(name="user_infos_id")
    private UserInfos userInfos;
    private String fullName;
    private String email;
    private String password;
}
