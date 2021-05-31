package com.inpt.lms.servicedevoirs.dto;

import lombok.Data;

import java.util.Date;

@Data
public class DevoirDTO {
    private String type;
    private String contenu;
    private Date dateLimite;
}
