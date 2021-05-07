package com.lms.servicepublications.controller;

import com.lms.servicepublications.dto.CommentaireDTO;
import com.lms.servicepublications.dto.LikeDTO;
import com.lms.servicepublications.service.CommentaireService;
import com.lms.servicepublications.service.LikeService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
public class CommentaireController {

    private CommentaireService commentaireService;

    @PostMapping("/commentaire")
    public void addLike(@RequestBody CommentaireDTO commentaireDTO){
        commentaireService.ajouterCommentaire(commentaireDTO);
    }
}
