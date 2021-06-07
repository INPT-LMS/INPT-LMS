package com.lms.servicepublications.dto;

import com.lms.servicepublications.model.Like;
import lombok.Data;

import java.util.List;
import java.util.UUID;

@Data
public class PublicationDTO {
    private UUID idCours;
    private String contenuPublication;
   // private String fichier;
    private String commentaire;
    private List<Like> likes;
}
