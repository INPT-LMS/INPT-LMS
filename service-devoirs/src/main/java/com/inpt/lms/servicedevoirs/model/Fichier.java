package com.inpt.lms.servicedevoirs.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.data.annotation.Id;

@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class Fichier {
    private String id;
    private String nom;
}
