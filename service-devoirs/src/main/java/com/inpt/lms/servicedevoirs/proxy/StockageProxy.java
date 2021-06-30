package com.inpt.lms.servicedevoirs.proxy;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


@FeignClient(name = "stockage", url = "${inpt.lms.url.service.stockage}")
@RequestMapping(path = "/storage")
public interface StockageProxy {
    @PostMapping(path = "admin/assignment/{devoirId}/response",
            consumes = "multipart/form-data")
    String uploadReponseDevoir(@RequestPart MultipartFile fichier,
                               @RequestHeader(name = "X-USER-ID") long userId, @PathVariable String devoirId);
}

