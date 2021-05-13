package com.lms.servicepublications.service;
import com.lms.servicepublications.dto.CommentaireDTO;
import com.lms.servicepublications.exceptions.RessourceNotFoundException;
import com.lms.servicepublications.exceptions.UnauthorizedException;
import com.lms.servicepublications.model.Commentaire;
import com.lms.servicepublications.model.Like;
import com.lms.servicepublications.model.Publication;
import com.lms.servicepublications.repository.CommentaireRepository;
import com.lms.servicepublications.repository.PublicationRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


@Service
@AllArgsConstructor
public class CommentaireService {

    private CommentaireRepository commentaireRepository;
    private PublicationRepository publicationRepository;


    /**
     * Fonction pour ajouter un commentaire
     * @return String
     */
    public String ajouterCommentaire(String id_user, CommentaireDTO commentaireDTO){
        Publication publication = publicationRepository.findById(commentaireDTO.getIdPublication()).orElseThrow(() -> new RessourceNotFoundException("Publication not found"));
        Commentaire commentaire = new Commentaire();
        commentaire.setIdProprietaire(id_user);
        commentaire.setIdPublication(commentaireDTO.getIdPublication());
        commentaire.setContenuCommentaire(commentaireDTO.getContenuCommentaire());
        commentaireRepository.insert(commentaire);


        if(publication.getCommentaires() == null){
            List<Commentaire> commentaires = new ArrayList<>();
            commentaires.add(commentaire);
            publication.setCommentaires(commentaires);
        }
        else{
            List<Commentaire> commentaires = publication.getCommentaires();
            commentaires.add(commentaire);
            publication.setCommentaires(commentaires);
        }

        publicationRepository.save(publication);
        return "Commentaire ajouté avec succèes";
    }

    /**
     * Fonction pour supprimer un commentaire par son id
     * @return String
     */
    public String supprimerCommentaire(String id_user, String idCommentaire) {
        Commentaire commentaire = (commentaireRepository.findById(idCommentaire).orElseThrow(() -> new RessourceNotFoundException("Comment not found")));
        if(!commentaire.getIdProprietaire().equals(id_user)) throw new UnauthorizedException("Action not authorized");
        Publication publication = publicationRepository.findById(commentaire.getIdPublication()).orElseThrow(() -> new RessourceNotFoundException("Publication not found"));
        List<Commentaire> commentaires = publication.getCommentaires();
        for (int i = 0; i < commentaires.size(); i++) {
            if (commentaires.get(i).getIdCommentaire().equals(idCommentaire)) {
                commentaires.remove(i);
            }
        }
        publication.setCommentaires(commentaires);
        commentaireRepository.deleteById(idCommentaire);
        publicationRepository.save(publication);
        return "Commentaire supprimé avec succèes";
    }

    /**
     * Fonction pour modifier un commentaire par son id
     * @return String
     */
    public String modifierCommentaire(String id_user,String id, CommentaireDTO commentaireDTO){
        Commentaire commentaire = commentaireRepository.findById(id).orElseThrow(()->new RessourceNotFoundException("Comment not found"));
        if(!commentaire.getIdProprietaire().equals(id_user)) throw new UnauthorizedException("Action not authorized");
        commentaire.setContenuCommentaire(commentaireDTO.getContenuCommentaire());
        commentaireRepository.save(commentaire);
        return "Commentaire modifié avec succès";
    }

    public void supprimerCommentairesInPublication(List<Commentaire> commentaires) {
        commentaireRepository.deleteAll(commentaires);
    }
}
