package com.lms.servicepublications.controller;

import com.lms.servicepublications.dto.LikeDTO;
import com.lms.servicepublications.exceptions.BadRequestException;
import com.lms.servicepublications.service.LikeService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;


@RestController
@AllArgsConstructor
public class LikeController {

    private LikeService likeService;

    @PostMapping("/like")
    public String postLike(@RequestHeader(value = "X-USER-ID", required = false) String id_user,
                           @RequestBody(required = false) LikeDTO likeDTO){
        if(id_user == null || id_user.equals(null)) throw new BadRequestException("User id is missing");
        if(likeDTO == null) throw new BadRequestException("Body is missing");
        return likeService.ajouterLike(id_user, likeDTO);
    }

    @DeleteMapping("/like/{idLike}")
    public String deleteLike(@RequestHeader(value = "X-USER-ID", required = false) String id_user,
                             @PathVariable String idLike){
        if(id_user == null || id_user.equals(null)) throw new BadRequestException("User id is missing");
        return likeService.supprimerLike(id_user, idLike);
    }
}
