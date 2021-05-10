package com.lms.servicepublications.controller;

import com.lms.servicepublications.dto.CommentaireDTO;
import com.lms.servicepublications.service.CommentaireService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;



@RestController
@AllArgsConstructor
public class CommentaireController {

    private CommentaireService commentaireService;

    @PostMapping("/commentaire")
    public void addLike(@RequestBody CommentaireDTO commentaireDTO){
        commentaireService.ajouterCommentaire(commentaireDTO);
    }

    @DeleteMapping("/commentaire/{idCommentaire}")
    public void deleteCommentaire(@PathVariable String idCommentaire){
        commentaireService.supprimerCommentaire(idCommentaire);
    }

    @PutMapping("/Comentaire/{idCommentaire}")
    public void putCommentaire(@PathVariable String idCommentaire, @RequestBody CommentaireDTO commentaireDTO){
        commentaireService.modifierCommentaire(idCommentaire, commentaireDTO);
    }
}
