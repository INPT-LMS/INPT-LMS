package com.lms.servicepublications.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;
@AllArgsConstructor
@NoArgsConstructor
@Data

@Document(collection = "commentaire")
public class Commentaire {
    @Id
    private String idCommentaire;
    private String idPublication;
    @CreatedDate
    private Date dateCommentaire;
    private String contenuCommentaire;
    private String idProprietaire;




}
