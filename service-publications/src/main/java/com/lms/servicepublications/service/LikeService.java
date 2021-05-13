package com.lms.servicepublications.service;
import com.lms.servicepublications.dto.LikeDTO;
import com.lms.servicepublications.exceptions.ResourceAlreadyExists;
import com.lms.servicepublications.exceptions.ResourceNotFoundException;
import com.lms.servicepublications.exceptions.UnauthorizedException;
import com.lms.servicepublications.model.Like;
import com.lms.servicepublications.model.Publication;
import com.lms.servicepublications.repository.LikeRepository;
import com.lms.servicepublications.repository.PublicationRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

// TODO Vérification de l'identité pour la suppression/Modification
@Service
@AllArgsConstructor

public class LikeService {
    private LikeRepository likeRepository;
    private PublicationRepository publicationRepository;


    public Like ajouterLike(String user_id, LikeDTO likeDTO){
        if(likeRepository.existsByIdProprietaire(user_id)) throw new ResourceAlreadyExists("You've already liked this post");
        Publication publication = publicationRepository.findById(likeDTO.getIdPublication()).orElseThrow(()->new ResourceNotFoundException("Publication not found"));
        Like like = new Like();
        like.setIdProprietaire(user_id);
        like.setIdPublication(likeDTO.getIdPublication());
        List<Like> likes = publication.getLikes();
        likes.add(like);
        publication.setLikes(likes);
        likeRepository.insert(like);
        publicationRepository.save(publication);
        return like;
    }


    public String supprimerLike(String id_user, String idLike){
        Like like = likeRepository.findById(idLike).orElseThrow(()->new ResourceNotFoundException("Like not found"));
        String idPublication = like.getIdPublication();
        if(!like.getIdProprietaire().equals(id_user)) throw new UnauthorizedException("Action not authorized");
        Publication publication = publicationRepository.findById(idPublication).orElseThrow(()->new ResourceNotFoundException("Publication not found"));
        List<Like> likes = publication.getLikes();
        for(int i =0; i<likes.size();i++){
            if (likes.get(i).getId().equals(idLike)){
                likes.remove(i);
            }
        }
        likeRepository.deleteById(idLike);
        publicationRepository.save(publication);
        return "Like supprimé avec succèes";
    }

    public void supprimerLikesInPublication(List<Like> likes){
        likeRepository.deleteAll(likes);
    }

}
