package com.lms.servicepublications.service;
import com.lms.servicepublications.dto.CommentaireDTO;
import com.lms.servicepublications.exceptions.RessourceNotFoundException;
import com.lms.servicepublications.exceptions.UnauthorizedException;
import com.lms.servicepublications.model.Commentaire;
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
    public String ajouterCommentaire(CommentaireDTO commentaireDTO){
        Commentaire commentaire = new Commentaire();
        commentaire.setContenuCommentaire(commentaireDTO.getContenuCommentaire());
        commentaireRepository.insert(commentaire);
        Publication publication = publicationRepository.findPublicationByid(commentaireDTO.getIdPublication());
        List<Commentaire> commentaires = new ArrayList();
        commentaires.add(commentaire);
        publication.setCommentaires(commentaires);
        publicationRepository.save(publication);
        return "Commentaire ajouté avec succèes";
    }

    /**
     * Fonction pour supprimer un commentaire par son id
     * @return String
     */
    public String supprimerCommentaire(String id_user, String idCommentaire) {
        Commentaire commentaire = (commentaireRepository.findById(idCommentaire).orElseThrow(() -> new RessourceNotFoundException("Comment not found")));
        String idPublication = commentaire.getIdPublication();
        if(!commentaire.getIdProprietaire().equals(id_user)) throw new UnauthorizedException("Action not authorized");
        Publication publication = publicationRepository.findById(idPublication).orElseThrow(() -> new RessourceNotFoundException("Publication not found"));
        List<Commentaire> commentaires = publication.getCommentaires();
        for (int i = 0; i < commentaires.size(); i++) {
            if (commentaires.get(i).getIdCommentaire().equals(idCommentaire)) {
                commentaires.remove(i);
            }
        }
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
}
