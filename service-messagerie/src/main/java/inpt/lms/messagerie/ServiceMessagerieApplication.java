package inpt.lms.messagerie;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Bean;

import inpt.lms.messagerie.proxies.CustomErrorDecoder;

@SpringBootApplication
@EnableFeignClients
public class ServiceMessagerieApplication {

	public static void main(String[] args) {
		SpringApplication.run(ServiceMessagerieApplication.class, args);
	}

	@Bean
	public CustomErrorDecoder getErrorDecoder() {
		return new CustomErrorDecoder();
	}
}
