package com.lms.servicepublications.controller;

import com.lms.servicepublications.dto.LikeDTO;
import com.lms.servicepublications.service.LikeService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;


@RestController
@AllArgsConstructor
public class LikeController {

    private LikeService likeService;

    @PostMapping("/like")
    public void postLike(@RequestBody LikeDTO likeDTO){
        likeService.ajouterLike(likeDTO);
    }

    @DeleteMapping("/like/{idLike}")
    public void deleteLike(@PathVariable String idLike){
        likeService.supprimerLike(idLike);
    }
}
