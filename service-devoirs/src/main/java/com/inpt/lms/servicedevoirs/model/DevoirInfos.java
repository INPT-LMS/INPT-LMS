package com.inpt.lms.servicedevoirs.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;

import java.util.Date;

@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class DevoirInfos {
    @Id
    private String id;
    private String contenu;
    // FIXME la date ne default pas
    @CreatedDate
    private Date dateCreation;
}
