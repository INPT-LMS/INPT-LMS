/*package com.lms.servicepublications.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Data
@Document(collection = "fichier")
public class Fichier {
    @Id
    private String id;
    private String idPublication;
    @CreatedDate
    private Date dateUpload;
    private String lienFichier;
    private String idProprietaire;

}
*/