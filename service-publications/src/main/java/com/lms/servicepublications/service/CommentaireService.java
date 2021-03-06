package com.lms.servicepublications.service;
import com.lms.servicepublications.beans.UserBean;
import com.lms.servicepublications.dto.CommentaireDTO;
import com.lms.servicepublications.exceptions.ResourceNotFoundException;
import com.lms.servicepublications.exceptions.UnauthorizedException;
import com.lms.servicepublications.model.Commentaire;
import com.lms.servicepublications.model.Publication;
import com.lms.servicepublications.proxies.GestionCompteProxy;
import com.lms.servicepublications.repository.CommentaireRepository;
import com.lms.servicepublications.repository.PublicationRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
@AllArgsConstructor
public class CommentaireService {

    private final CommentaireRepository commentaireRepository;
    private final PublicationRepository publicationRepository;
    private final GestionCompteProxy gestionCompteProxy;


    /**
     * Fonction pour ajouter un commentaire
     * @return String
     */
    public Commentaire ajouterCommentaire(Long id_user, CommentaireDTO commentaireDTO){
        UserBean userBean = gestionCompteProxy.getNameById(id_user);
        Publication publication = publicationRepository.findById(commentaireDTO.getIdPublication()).orElseThrow(() -> new ResourceNotFoundException("Publication not found"));
        Commentaire commentaire = new Commentaire();
        commentaire.setIdProprietaire(id_user);
        commentaire.setNomUser(userBean.getUser().getNom());
        commentaire.setPrenomUser(userBean.getUser().getPrenom());
        commentaire.setIdPublication(commentaireDTO.getIdPublication());
        commentaire.setContenuCommentaire(commentaireDTO.getContenuCommentaire());
        List<Commentaire> commentaires = publication.getCommentaires();
        System.out.println(commentaire.getId());
        commentaires.add(commentaire);
        publication.setCommentaires(commentaires);
        commentaireRepository.insert(commentaire);
        publicationRepository.save(publication);
        return commentaire;
    }

    /**
     * Fonction pour supprimer un commentaire par son id
     * @return String
     */
    public String supprimerCommentaire(Long id_user, String idCommentaire) {
        Commentaire commentaire = (commentaireRepository.findById(idCommentaire).orElseThrow(() -> new ResourceNotFoundException("Comment not found")));
        if(!commentaire.getIdProprietaire().equals(id_user)) throw new UnauthorizedException("Action not authorized");
        Publication publication = publicationRepository.findById(commentaire.getIdPublication()).orElseThrow(() -> new ResourceNotFoundException("Publication not found"));
        List<Commentaire> commentaires = publication.getCommentaires();
        for (int i = 0; i < commentaires.size(); i++) {
            if (commentaires.get(i).getId().equals(idCommentaire)) {
                commentaires.remove(i);
            }
        }
        publication.setCommentaires(commentaires);
        commentaireRepository.deleteById(idCommentaire);
        publicationRepository.save(publication);
        return "{\"Message\":\"Commentaire supprim??e avec succ??s\"}";
    }

    /**
     * Fonction pour modifier un commentaire par son id
     * @return String
     */
    public String modifierCommentaire(Long id_user,String id, CommentaireDTO commentaireDTO){
        Commentaire commentaire = commentaireRepository.findById(id).orElseThrow(()->new ResourceNotFoundException("Comment not found"));
        if(!commentaire.getIdProprietaire().equals(id_user)) throw new UnauthorizedException("Action not authorized");
        commentaire.setContenuCommentaire(commentaireDTO.getContenuCommentaire());
        commentaireRepository.save(commentaire);
        return "{\"Message\":\"Commentaire modifi?? avec succ??s\"}";

    }

    public void supprimerCommentairesInPublication(List<Commentaire> commentaires) {
        commentaireRepository.deleteAll(commentaires);
    }
}
