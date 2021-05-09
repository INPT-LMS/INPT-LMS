package inpt.lms.gateway;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import io.jsonwebtoken.JwtParser;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.jackson.io.JacksonDeserializer;
import io.jsonwebtoken.lang.Maps;

@SpringBootApplication
public class GatewayApplication {

	public static void main(String[] args) {
		SpringApplication.run(GatewayApplication.class, args);
	}
	
	@Bean
	public JwtParser getJwtParser(@Value("${inpt.lms.secret}") String key) {
		return Jwts.parserBuilder().deserializeJsonWith(
				new JacksonDeserializer(Maps.of("id", Long.class).build()))
				.setSigningKey(key).build();
	}
}
