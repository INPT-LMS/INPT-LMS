package com.inpt.lms.servicedevoirs.dto;

import lombok.Data;

@Data
public class DevoirDTO {
    private String idCours;
    private String idProprietaire;
    private String type;
    private String contenu;
}
