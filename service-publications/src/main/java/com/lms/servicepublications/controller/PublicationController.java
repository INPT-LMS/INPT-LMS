package com.lms.servicepublications.controller;


import com.lms.servicepublications.dto.PublicationDTO;
import com.lms.servicepublications.exceptions.BadRequestException;
import com.lms.servicepublications.model.Publication;
import com.lms.servicepublications.service.PublicationService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
public class PublicationController {

    private PublicationService publicationService;

    @GetMapping("/publication/{idPublication}")
    public Publication getPublication(@PathVariable String idPublication){
        Publication publication = publicationService.recupererPublication(idPublication);
        return publication;
    }

    @GetMapping("/publication")
    public List<Publication> getPublications(){
       List<Publication> publications = publicationService.recupererPublications();
        return publications;
    }

//    @GetMapping("/publication/{idCours}")
//    public List<Publication> getPublicationsByCourse(@PathVariable String idCours){
//
//        List<Publication> publications = publicationService.recupererPublicationsParCours(idCours);
//        return publications;
//    }

    @PostMapping("/publication")
    public Publication addPublication(@RequestHeader(value = "X-USER-ID", required = false) String id_user,
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
                                  @RequestHeader(value = "X-USER-ID", required = false) String id_user){
        if(id_user == null || id_user.equals("")) throw new BadRequestException("User id is missing");
        return publicationService.modifierPublication(id_user, idPublication, publicationDTO);


    }
}
