package com.inpt.lms.servicedevoirs;

import feign.codec.Encoder;
import feign.form.spring.SpringFormEncoder;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@SpringBootApplication
@EnableFeignClients
public class ServiceDevoirsApplication {

    public static void main(String[] args) {
        SpringApplication.run(ServiceDevoirsApplication.class, args);
    }

}
