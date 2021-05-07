package com.lms.servicepublications.controller;

import com.lms.servicepublications.dto.LikeDTO;
import com.lms.servicepublications.dto.PublicationDTO;
import com.lms.servicepublications.model.Like;
import com.lms.servicepublications.model.Publication;
import com.lms.servicepublications.repository.LikeRepository;
import com.lms.servicepublications.repository.PublicationRepository;
import com.lms.servicepublications.service.LikeService;
import com.lms.servicepublications.service.PublicationService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@AllArgsConstructor
public class LikeController {

    private LikeService likeService;

    @PostMapping("/likes")
    public void addLike(@RequestBody LikeDTO likeDTO){
        likeService.ajouterLike(likeDTO);
    }
}
