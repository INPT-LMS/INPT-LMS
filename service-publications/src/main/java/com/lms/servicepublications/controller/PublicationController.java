package com.lms.servicepublications.controller;


import com.lms.servicepublications.dto.PublicationDTO;
import com.lms.servicepublications.model.Publication;
import com.lms.servicepublications.service.PublicationService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
public class PublicationController {

    private PublicationService publicationService;

   /* @GetMapping("/publications/{idPublication}")
    public Publication getPublication(@PathVariable String idPublication){
        Publication publication = publicationService.recupererPublication(idPublication);
        return publication;
    }*/

    @GetMapping("/publication")
    public List<Publication> getPublications(){
       List<Publication> publications = publicationService.recupererPublications();
        return publications;
    }

    @GetMapping("/publication/{idCours}")
    public List<Publication> getPublicationsByCourse(@PathVariable String idCours){
        List<Publication> publications = publicationService.recupererPublicationsParCours(idCours);
        return publications;
    }

    @PostMapping("/publication")
    public void addPublication(@RequestBody PublicationDTO publicationDTO){
        publicationService.ajouterPublication(publicationDTO);
    }

    @DeleteMapping("publication/{idPublication}")
    public void removePublication(@PathVariable String idPublication){
        publicationService.supprimerPublication(idPublication);
    }

    @PutMapping("publication/{idPublication}")
    public void updatePublication(@PathVariable String idPublication,@RequestBody PublicationDTO publicationDTO){
        publicationService.modifierPublication(idPublication,publicationDTO);
    }
}
