package com.lms.servicepublications.proxies;

import com.lms.servicepublications.beans.CoursBean;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;

import java.util.List;

@FeignClient(name = "cours", url="localhost:8306/public")
public interface CoursProxy {

    @GetMapping("student/courses")
    public List<CoursBean> getIdCoursByStudent(@RequestHeader("X-USER-ID") long userID);
}
