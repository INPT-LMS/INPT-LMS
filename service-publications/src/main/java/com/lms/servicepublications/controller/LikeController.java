package com.lms.servicepublications.controller;

import com.lms.servicepublications.dto.LikeDTO;
import com.lms.servicepublications.exceptions.BadRequestException;
import com.lms.servicepublications.model.Like;
import com.lms.servicepublications.service.LikeService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;


@RestController
@AllArgsConstructor
public class LikeController {

    private final LikeService likeService;

    @PostMapping("/like")
    public Like postLike(@RequestHeader(value = "X-USER-ID", required = false) Long id_user,
                         @RequestBody(required = false) LikeDTO likeDTO){
        if(id_user == null) throw new BadRequestException("User id is missing");
        if(likeDTO == null) throw new BadRequestException("Body is missing");
        return likeService.ajouterLike(id_user, likeDTO);
    }

    @DeleteMapping("/like/{idLike}")
    public String deleteLike(@RequestHeader(value = "X-USER-ID", required = false) Long id_user,
                             @PathVariable String idLike){
        if(id_user == null) throw new BadRequestException("User id is missing");
        return likeService.supprimerLike(id_user, idLike);
    }
}
