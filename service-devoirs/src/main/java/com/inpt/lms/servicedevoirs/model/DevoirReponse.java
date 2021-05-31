package com.inpt.lms.servicedevoirs.model;

import lombok.*;
import org.springframework.data.annotation.Id;

@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class DevoirReponse {
    @Id
    private String id;
    private Long idProprietaire;
    private Fichier fichier;
    private int note;
    private boolean estNote;
}
