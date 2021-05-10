package com.lms.servicepublications.service;
import com.lms.servicepublications.dto.LikeDTO;
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


    public void ajouterLike(LikeDTO likeDTO){
        Like like = new Like();
        like.setIdProprietaire(likeDTO.getIdProprietaire());
        like.setIdPublication(likeDTO.getIdPublication());

        likeRepository.insert(like);

        Publication publication = publicationRepository.findPublicationByid(likeDTO.getIdPublication());

        List<Like> likes = new ArrayList();

        likes.add(like);
        publication.setLikes(likes);
        publicationRepository.save(publication);
        System.out.println("Like ajouté avec succèes");
    }


    public void supprimerLike(String idLike){
        String idPublication = (likeRepository.findById(idLike).orElseThrow(()->new RuntimeException())).getIdPublication();
        Publication publication = publicationRepository.findPublicationByid(idPublication);
        List<Like> likes = publication.getLikes();
        for(int i =0; i<likes.size();i++){
            if (likes.get(i).getIdLike().equals(idLike)){
                likes.remove(i);
            }
        }
        likeRepository.deleteById(idLike);
        publicationRepository.save(publication);
        System.out.println("Like supprimé avec succèes");
    }
}
