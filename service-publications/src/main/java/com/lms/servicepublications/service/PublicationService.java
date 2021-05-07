package com.lms.servicepublications.service;


import com.lms.servicepublications.dto.PublicationDTO;
import com.lms.servicepublications.model.Commentaire;
import com.lms.servicepublications.model.Like;
import com.lms.servicepublications.model.Publication;
import com.lms.servicepublications.repository.CommentaireRepository;
import com.lms.servicepublications.repository.FichierRepository;
import com.lms.servicepublications.repository.LikeRepository;
import com.lms.servicepublications.repository.PublicationRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

// TODO verification de l'identité
@Service
@AllArgsConstructor

public class PublicationService {

    private final PublicationRepository publicationRepository;
    private final FichierRepository fichierRepository;
    private final LikeRepository likeRepository;
    private final CommentaireRepository commentaireRepository;

    /**
     * Fonction pour récupérer une publication
     * @return
     */
    public Publication recupererPublication(String id_publication){
        Publication publication = publicationRepository.findById(id_publication).orElseThrow(()->new RuntimeException());
        return publication;
    }

    public List<Publication> recupererPublications(){
        List<Publication> publications = publicationRepository.findAll();
        return publications;
    }
    public List<Publication> recupererPublicationsParCours(String idCours){
        List<Publication> publications = publicationRepository.findByidCours(idCours);
        return publications;
    }
    public void ajouterPublication(PublicationDTO publicationDTO){
        Publication publication = new Publication();
        publication.setContenuPublication(publicationDTO.getContenuPublication());
        publication.setFichier(publicationDTO.getFichier());
        publication.setIdCours(publicationDTO.getIdCours());
//
//        List<Like> likes = new ArrayList();
//        Like like = new Like();
//        likes.add(like);
//        publication.setLikes(likes);
//
//
//        List<Commentaire> commentaires = new ArrayList();
//        Commentaire commentaire = new Commentaire();
//        commentaires.add(commentaire);
//        publication.setCommentaires(commentaires);


        publication.setIdProprietaire(publicationDTO.getIdProprietaire());
        publicationRepository.insert(publication);
        System.out.println("publication ajoutée avec succées");
    }

    public void supprimerPublication(String idPublication){
        publicationRepository.deleteById(idPublication);
        System.out.println("publication supprimée avec succées");
    }

    public Publication modifierPublication(String id,PublicationDTO publicationDTO){
        Publication publication = publicationRepository.findPublicationByid(id);
        publication.setContenuPublication(publicationDTO.getContenuPublication());
        List<Like> likes = new ArrayList();
        publication.setLikes(likes);
        List<Commentaire> commentaires = new ArrayList();
        publication.setCommentaires(commentaires);
        publication.setFichier(publicationDTO.getFichier());
        publication.setIdCours(publicationDTO.getIdCours());
        publication.setIdProprietaire(publicationDTO.getIdProprietaire());
        System.out.println("publication modifiée avec succées");
        return publicationRepository.save(publication);
    }
}
