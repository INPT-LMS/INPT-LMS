package com.lms.servicepublications.proxies;

import com.lms.servicepublications.beans.UserInfoBean;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;


@FeignClient(name = "gestioncompte", url="${inpt.lms.url.service.gesioncompte}")
public interface GestionCompteProxy {

    @GetMapping("/user/{userID}")
    UserInfoBean getNameById(@PathVariable long userID);
}
