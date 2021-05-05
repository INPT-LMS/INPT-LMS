package com.inpt.lms.servicegestioncomptes.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class UserCredentialsDTO {
    private String email;
    private String password;
}
