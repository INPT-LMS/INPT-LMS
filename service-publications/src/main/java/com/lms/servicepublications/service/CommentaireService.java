package com.lms.servicepublications.service;
import com.lms.servicepublications.dto.CommentaireDTO;
import com.lms.servicepublications.dto.PublicationDTO;
import com.lms.servicepublications.model.Commentaire;
import com.lms.servicepublications.model.Like;
import com.lms.servicepublications.model.Publication;
import com.lms.servicepublications.repository.CommentaireRepository;
import com.lms.servicepublications.repository.PublicationRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

// TODO Vérification de l'identité pour la suppression/Modification
@Service
@AllArgsConstructor
public class CommentaireService {

    private CommentaireRepository commentaireRepository;
    private PublicationRepository publicationRepository;

    public void ajouterCommentaire(CommentaireDTO commentaireDTO){
        Commentaire commentaire = new Commentaire();
        commentaire.setIdProprietaire(commentaireDTO.getIdProprietaire());
        commentaire.setIdPublication(commentaireDTO.getIdPublication());
        commentaire.setContenuCommentaire(commentaireDTO.getContenuCommentaire());

        commentaireRepository.insert(commentaire);

        Publication publication = publicationRepository.findPublicationByid(commentaireDTO.getIdPublication());

        List<Commentaire> commentaires = new ArrayList();

        commentaires.add(commentaire);
        publication.setCommentaires(commentaires);
        publicationRepository.save(publication);
        System.out.println("Commentaire ajouté avec succèes");
    }

    public void supprimerCommentaire(String idCommentaire) {
        String idPublication = (commentaireRepository.findById(idCommentaire).orElseThrow(() -> new RuntimeException())).getIdPublication();
        Publication publication = publicationRepository.findPublicationByid(idPublication);
        List<Commentaire> commentaires = publication.getCommentaires();
        for (int i = 0; i < commentaires.size(); i++) {
            if (commentaires.get(i).getIdCommentaire().equals(idCommentaire)) {
                commentaires.remove(i);
            }
        }
        commentaireRepository.deleteById(idCommentaire);
        publicationRepository.save(publication);
        System.out.println("Commentaire supprimé avec succèes");
    }

    public void modifierCommentaire(String id, CommentaireDTO commentaireDTO){
        Commentaire commentaire = commentaireRepository.findById(id).orElseThrow(()->new RuntimeException());
        commentaire.setContenuCommentaire(commentaireDTO.getContenuCommentaire());
        System.out.println("Commentaire modifié avec succès");
    }
}
