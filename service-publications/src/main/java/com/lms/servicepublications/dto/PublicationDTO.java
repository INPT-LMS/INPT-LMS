package com.lms.servicepublications.dto;

import com.lms.servicepublications.model.Like;
import lombok.Data;

import java.util.List;

@Data
public class PublicationDTO {
    private String idCours;
    private String contenuPublication;
   // private String fichier;
    private String commentaire;
    private List<Like> likes;
}
