package com.inpt.lms.servicegestioncomptes.dto;

import lombok.Data;

@Data
public class PasswordUpdateDTO {
    String oldPassword;
    String newPassword;
}
