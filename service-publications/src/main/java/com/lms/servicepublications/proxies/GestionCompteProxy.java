package com.lms.servicepublications.proxies;

import com.lms.servicepublications.beans.UserInfoBean;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;


@FeignClient(name = "cours", url="${inpt.lms.url.service.gesioncompte}")
public interface GestionCompteProxy {

    @GetMapping("/public/student/courses")
    UserInfoBean getNameById(@PathVariable long userID);
}
