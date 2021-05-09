package inpt.lms.gateway.filters;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;

import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.JwtParser;
import reactor.core.publisher.Mono;

@Component
public class TokenValidationFilter implements GatewayFilter{
	@Autowired
	protected JwtParser parser;
	@Override
	public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
		ServerHttpRequest request = exchange.getRequest();
		ServerHttpResponse response = exchange.getResponse();
		List<String> values = request.getHeaders().getValuesAsList("Authorization");
		if (values.size() != 1)
			return erreur(response);
		String token;
		try {
			token = values.get(0).substring(7);
		} catch (IndexOutOfBoundsException e) {
			return erreur(response);
		}
		
		try {
			Long userId = parser.parseClaimsJws(token).getBody().get("userId", Long.class);
			ServerHttpRequest newRequest = request.mutate()
                    .header("X-USER-ID", userId.toString())
                    .build();
            return chain.filter(exchange.mutate().request(newRequest).build());
		} catch (JwtException e) {
			return erreur(response);
		}
	}
	private Mono<Void> erreur(ServerHttpResponse response) {
		response.setStatusCode(HttpStatus.UNAUTHORIZED);
		return response.setComplete();
	}
	public JwtParser getParser() {
		return parser;
	}
	public void setParser(JwtParser parser) {
		this.parser = parser;
	}
}
