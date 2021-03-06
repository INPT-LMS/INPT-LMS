package com.lms.servicepublications.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;
import java.util.List;
import java.util.UUID;

@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
@Document(collection = "publication")
public class Publication {

    @Id
    private String id;
    private Long idProprietaire;
    private UUID idCours;
    private String nomUser;
    private String prenomUser;
    @CreatedDate
    private Date datePublication;
    private String contenuPublication;
    //private List<Fichier> fichiers;
    private List<Commentaire> commentaires;
    private List<Like> likes;
}
