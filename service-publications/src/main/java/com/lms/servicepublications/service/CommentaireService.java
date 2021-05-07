package com.lms.servicepublications.service;
import com.lms.servicepublications.dto.CommentaireDTO;
import com.lms.servicepublications.model.Commentaire;
import com.lms.servicepublications.model.Publication;
import com.lms.servicepublications.repository.CommentaireRepository;
import com.lms.servicepublications.repository.PublicationRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

// TODO verification de l'identité
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
}
