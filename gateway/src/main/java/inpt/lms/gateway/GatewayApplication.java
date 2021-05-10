package inpt.lms.gateway;

import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import io.jsonwebtoken.JwtParser;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.jackson.io.JacksonDeserializer;
import io.jsonwebtoken.lang.Maps;

import java.security.Key;
import java.util.Base64;

@SpringBootApplication
public class GatewayApplication {

	public static void main(String[] args) {
		SpringApplication.run(GatewayApplication.class, args);
	}
	
	@Bean
	public JwtParser getJwtParser(@Value("${inpt.lms.secret}") String key) {
		byte[] DEC_SECRET = Base64.getDecoder().decode(key);
		Key k = Keys.hmacShaKeyFor(DEC_SECRET);

		return Jwts.parserBuilder().deserializeJsonWith(
				new JacksonDeserializer(Maps.of("id", Long.class).build()))
				.setSigningKey(k).build();
	}
}
