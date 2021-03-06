package com.inpt.lms.servicedevoirs;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableFeignClients
public class ServiceDevoirsApplication {

    public static void main(String[] args) {
        SpringApplication.run(ServiceDevoirsApplication.class, args);
    }

}
