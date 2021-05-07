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

@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
@Document(collection = "publication")
public class Publication {

    @Id
    private String id;
    private String idProprietaire;
    private String idCours;
    @CreatedDate
    private Date datePublication;
    private String contenuPublication;
    private String fichier;
    private List<Commentaire> commentaires;
    private List<Like> likes;
}
