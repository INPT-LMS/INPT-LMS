package com.lms.servicepublications;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.data.mongodb.config.EnableMongoAuditing;

@EnableMongoAuditing
@SpringBootApplication
@EnableFeignClients
public class ServicePublicationsApplication {

    public static void main(String[] args) {
        SpringApplication.run(ServicePublicationsApplication.class, args);
    }

}
