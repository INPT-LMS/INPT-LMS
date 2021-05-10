package com.lms.servicepublications;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.mongodb.config.EnableMongoAuditing;

@EnableMongoAuditing
@SpringBootApplication
public class ServicePublicationsApplication {

    public static void main(String[] args) {
        SpringApplication.run(ServicePublicationsApplication.class, args);
    }

}
