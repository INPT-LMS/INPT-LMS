package com.inpt.lms.servicedevoirs.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.data.annotation.Id;

import java.util.Date;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class Devoir {
    @Id
    private String id;
    private String idCours;
    private Long idProprietaire;
    private String type;
    private DevoirInfos devoirInfos;
    private List<DevoirReponse> reponses;
    private Date dateLimite;
}
