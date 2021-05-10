package com.inpt.lms.servicedevoirs.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.data.annotation.Id;

import java.util.List;
import java.util.UUID;

@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class Devoir {
    @Id
    private String id;
    private UUID idCours;
    private String idProprietaire;
    private String type;
    private DevoirInfos devoirInfos;
    private List<DevoirReponse> reponses;
}
