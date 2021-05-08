package inpt.lms.gateway.routes;

import java.util.function.Function;

import org.springframework.cloud.gateway.route.Route;
import org.springframework.cloud.gateway.route.builder.Buildable;
import org.springframework.cloud.gateway.route.builder.PredicateSpec;

import inpt.lms.gateway.filters.TokenValidationFilter;

public class RouteCreatorUtil {	
	private RouteCreatorUtil() {
		throw new IllegalStateException("Utility class");
	}

	public static Function<PredicateSpec, Buildable<Route>> getProtectedRoute(
			String beginPath,String endPath,String endUri,
			TokenValidationFilter tokenFilter){
		String beginPathValue = beginPath.endsWith("/") ? beginPath+"?*/**" : beginPath;
		return p -> p.path(beginPathValue)
				.filters(f -> {
					f = f.filter(tokenFilter);
					return beginPath.endsWith("/") ? 
							f.rewritePath(beginPath+"(?<segment>.*)",endPath+"${segment}") 
							: f.rewritePath(beginPath, endPath);
				})
				.uri(endUri);
	}

	public static Function<PredicateSpec, Buildable<Route>> getRoute(
			String beginPath,String endPath,String endUri){
		String beginPathValue = beginPath.endsWith("/") ? beginPath+"?*/**" : beginPath;
		return p -> p.path(beginPathValue)
				.filters(f -> beginPath.endsWith("/") ? 
						f.rewritePath(beginPath+"(?<segment>.*)",endPath+"${segment}") 
						: f.rewritePath(beginPath, endPath))
				.uri(endUri);
	}
}
