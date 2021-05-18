package com.lms.servicepublications.controller;


import com.lms.servicepublications.beans.CoursBean;
import com.lms.servicepublications.dto.PublicationDTO;
import com.lms.servicepublications.exceptions.BadRequestException;
import com.lms.servicepublications.model.Publication;
import com.lms.servicepublications.proxies.CoursProxy;
import com.lms.servicepublications.service.PublicationService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

@RestController
@AllArgsConstructor
public class PublicationController {

    private final CoursProxy coursProxy;
    private final PublicationService publicationService;

    @GetMapping("/publication/{idPublication}")
    public Publication getPublication(@PathVariable String idPublication){
        return publicationService.recupererPublication(idPublication);
    }

    @GetMapping("/publication")
    public List<Publication> getPublications(){
        return publicationService.recupererPublications();
    }

    @GetMapping("/publication/cours/{idCours}")
    public List<Publication> getPublicationsByCourse(@PathVariable UUID idCours){
        return publicationService.recupererPublicationsParCours(idCours);
    }

    @GetMapping("/publication/cours")
    public HashMap<UUID,List<Publication>> getPublicationsByCourses2(@RequestHeader(value = "X-USER-ID") Long id_user){
        List<CoursBean> coursBeans = coursProxy.getIdCoursByStudent(id_user);
        System.out.println("************************************************");
        System.out.println("ceci est coursBeans : "+coursBeans);
        return publicationService.recupererPublicationsParCours2(coursBeans);
    }

    @PostMapping("/publication")
    public Publication addPublication(@RequestHeader(value = "X-USER-ID", required = false) Long id_user,
            @RequestBody PublicationDTO publicationDTO){
        if(id_user == null || id_user.equals(null)) throw new BadRequestException("User id is missing");
        return publicationService.ajouterPublication(id_user, publicationDTO);
    }

    @DeleteMapping("publication/{idPublication}")
    public String removePublication(@RequestHeader(value = "X-USER-ID", required = false) String id_user, @PathVariable String idPublication){
        if(id_user == null || id_user.equals(null)) throw new BadRequestException("User id is missing");
        return publicationService.supprimerPublication(id_user, idPublication);
    }

    @PutMapping("publication/{idPublication}")
    public Publication updatePublication(@PathVariable String idPublication,
                                  @RequestBody PublicationDTO publicationDTO,
                                  @RequestHeader(value = "X-USER-ID", required = false) Long id_user){
        if(id_user == null || id_user.equals("")) throw new BadRequestException("User id is missing");
        return publicationService.modifierPublication(id_user, idPublication, publicationDTO);


    }
}
