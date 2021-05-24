package com.lms.servicepublications.service;


import com.lms.servicepublications.beans.CoursBean;
import com.lms.servicepublications.dto.PublicationDTO;
import com.lms.servicepublications.exceptions.ResourceNotFoundException;
import com.lms.servicepublications.exceptions.UnauthorizedException;
import com.lms.servicepublications.model.Commentaire;
import com.lms.servicepublications.model.Like;
import com.lms.servicepublications.model.Publication;
import com.lms.servicepublications.repository.PublicationRepository;
import lombok.AllArgsConstructor;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

@Service
@AllArgsConstructor

public class PublicationService {

    private final PublicationRepository publicationRepository;
    private final CommentaireService commentaireService;
    private final LikeService likeService;



    /**
     * Fonction pour récupérer une publication par son id
     * @return Publication
     */
    public Publication recupererPublication(String id_publication){
        return publicationRepository.findById(id_publication).orElseThrow(()->new ResourceNotFoundException("Requested publication is not found."));
    }

    /**
     * Fonction pour récupérer toutes les publications
     * @return Publication
     */
    public List<Publication> recupererPublications(){
        return publicationRepository.findAll();
    }

    /**
     * Fonction pour récupérer les publications par cours
     * @return Publication
     */
    public List<Publication> recupererPublicationsParCours(UUID idCours){
        return publicationRepository.findByidCoursOrderByDatePublicationDesc(idCours);
    }

    public HashMap<UUID,List<Publication>> recupererPublicationsParCours2(List<CoursBean> cours){
        HashMap<UUID,List<Publication>> PublicationsParCours = new HashMap<>();
        if(!(cours==null)){
            for (CoursBean cour : cours) {
                if (!(cour == null)) {
                    PublicationsParCours.put(cour.getCourseID(), publicationRepository.findByidCoursOrderByDatePublicationDesc(cour.getCourseID()));
                    //  PublicationsParCours.put(cours.get(i).getCourseID(),publicationRepository.findByidCoursOrderByDatePublicationDesc(cours.get(i).getCourseID()).subList(0,limit-1));
                }
            }
         return PublicationsParCours;
        }
        return PublicationsParCours;
    }

    /**
     * Fonction pour ajouter une publications
     * @return String
     */
    public Publication ajouterPublication(long id_user, PublicationDTO publicationDTO){
        Publication publication = new Publication();
        publication.setContenuPublication(publicationDTO.getContenuPublication());
        publication.setIdCours(publicationDTO.getIdCours());
        publication.setIdProprietaire(id_user);
        publication.setCommentaires(new ArrayList<Commentaire>());
        publication.setLikes(new ArrayList<Like>());
        return publicationRepository.insert(publication);
    }


    /**
     * Fonction pour supprimer une publications par son id
     * @return String
     */
    public String supprimerPublication(long id_user, String idPublication){
        Publication publication = publicationRepository.findById(idPublication).orElseThrow(()->new ResourceNotFoundException("Requested publication is not found."));
        if(!(publication.getIdProprietaire().equals(id_user))) throw new UnauthorizedException("Action not authorized");
        commentaireService.supprimerCommentairesInPublication(publication.getCommentaires());
        likeService.supprimerLikesInPublication(publication.getLikes());
        publicationRepository.deleteById(idPublication);
        return "{\"Message\":\"Publication supprimée avec succès\"}";
    }


    /**
     * Fonction pour modifier une publications par son id
     * @return String
     */
    public Publication modifierPublication(Long user_id,String publication_id,PublicationDTO publicationDTO){
        Publication publication = publicationRepository.findById(publication_id).orElseThrow(()->new ResourceNotFoundException("Requested publication is not found."));
        if(!(publication.getIdProprietaire().equals(user_id))) throw new UnauthorizedException("Action not authorized");
        publication.setContenuPublication(publicationDTO.getContenuPublication());
        publication.setIdCours(publicationDTO.getIdCours());
        return publicationRepository.save(publication);
    }
}
