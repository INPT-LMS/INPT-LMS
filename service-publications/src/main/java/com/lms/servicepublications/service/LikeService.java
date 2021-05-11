package com.lms.servicepublications.service;
import com.lms.servicepublications.dto.LikeDTO;
import com.lms.servicepublications.exceptions.RessourceNotFoundException;
import com.lms.servicepublications.exceptions.UnauthorizedException;
import com.lms.servicepublications.model.Like;
import com.lms.servicepublications.model.Publication;
import com.lms.servicepublications.repository.LikeRepository;
import com.lms.servicepublications.repository.PublicationRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

// TODO Vérification de l'identité pour la suppression/Modification
@Service
@AllArgsConstructor

public class LikeService {
    private LikeRepository likeRepository;
    private PublicationRepository publicationRepository;


    public String ajouterLike(LikeDTO likeDTO){
        Like like = new Like();
        like.setIdProprietaire(likeDTO.getIdProprietaire());
        like.setIdPublication(likeDTO.getIdPublication());

        likeRepository.insert(like);

        Publication publication = publicationRepository.findPublicationByid(likeDTO.getIdPublication());

        List<Like> likes = new ArrayList();

        likes.add(like);
        publication.setLikes(likes);
        publicationRepository.save(publication);
        return "Like ajouté avec succèes";
    }


    public String supprimerLike(String id_user, String idLike){
        Like like = likeRepository.findById(idLike).orElseThrow(()->new RessourceNotFoundException("Like not found"));
        String idPublication = like.getIdPublication();
        if(!like.getIdProprietaire().equals(id_user)) throw new UnauthorizedException("Action not authorized");
        Publication publication = publicationRepository.findById(idPublication).orElseThrow(()->new RessourceNotFoundException("Publication not found"));
        List<Like> likes = publication.getLikes();
        for(int i =0; i<likes.size();i++){
            if (likes.get(i).getIdLike().equals(idLike)){
                likes.remove(i);
            }
        }
        likeRepository.deleteById(idLike);
        publicationRepository.save(publication);
        return "Like supprimé avec succèes";
    }
}
