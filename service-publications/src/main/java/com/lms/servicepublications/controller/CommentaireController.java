package com.lms.servicepublications.controller;

import com.lms.servicepublications.dto.CommentaireDTO;
import com.lms.servicepublications.exceptions.BadRequestException;
import com.lms.servicepublications.service.CommentaireService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;



@RestController
@AllArgsConstructor
public class CommentaireController {

    private CommentaireService commentaireService;

    @PostMapping("/commentaire")
    public String addCommentaore(@RequestHeader(value = "X-USER-ID", required = false) String id_user,
                                 @RequestBody(required = false) CommentaireDTO commentaireDTO){
        if(id_user == null || id_user.equals("")) throw new BadRequestException("User id is missing");
        if(commentaireDTO==null) throw new BadRequestException("Body is missing");
        return commentaireService.ajouterCommentaire(id_user, commentaireDTO);
    }

    @DeleteMapping("/commentaire/{idCommentaire}")
    public String deleteCommentaire(@RequestHeader(value = "X-USER-ID", required = false) String id_user,
                                    @PathVariable String idCommentaire){
        if(id_user == null || id_user.equals("")) throw new BadRequestException("User id is missing");
        return commentaireService.supprimerCommentaire(id_user, idCommentaire);
    }

    @PutMapping("/Comentaire/{idCommentaire}")
    public String putCommentaire(@RequestHeader(value = "X-USER-ID", required = false) String id_user,
                                 @PathVariable String idCommentaire,
                                 @RequestBody CommentaireDTO commentaireDTO){
        if(id_user == null || id_user.equals("")) throw new BadRequestException("User id is missing");
        return commentaireService.modifierCommentaire(id_user, idCommentaire, commentaireDTO);
    }
}
