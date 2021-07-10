package inpt.lms.gateway.routes;

import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import inpt.lms.gateway.filters.TokenValidationFilter;

@Configuration
public class RoutesConfiguration {
	@Bean
	public RouteLocator myRoutes(RouteLocatorBuilder builder,TokenValidationFilter 
			tokenValidation, UrlsProperties urls) {
		return builder.routes()
				.route(RouteCreatorUtil.getAdminRoute("/storage/admin/", urls.getStockage()))
				.route(RouteCreatorUtil.getRoute("/storage/user/picture/","/storage/user/picture/",
						urls.getStockage()))
				.route(RouteCreatorUtil.getProtectedRoute("/storage/","/storage/",
						urls.getStockage(),tokenValidation))
				.route(RouteCreatorUtil.getProtectedRoute("/messagebox/","/messagerie/",
						urls.getMessagerie(),tokenValidation))
				.route(RouteCreatorUtil.getRoute("/account/auth","/auth",
						urls.getGestioncompte()))
				.route(RouteCreatorUtil.getRoute("/account/register","/register",
						urls.getGestioncompte()))
				.route(RouteCreatorUtil.getRoute("/account/user/","/user/",
						urls.getGestioncompte()))
				.route(RouteCreatorUtil.getProtectedRoute("/account/","/",
						urls.getGestioncompte(),tokenValidation))
				.route(RouteCreatorUtil.getProtectedRoute("/assignment/","/",
						urls.getDevoir(),tokenValidation))
				.route(RouteCreatorUtil.getProtectedRoute("/post/","/",
						urls.getPublication(),tokenValidation))
				.route(RouteCreatorUtil.getProtectedRoute("/class/","/public/",
						urls.getCours(),tokenValidation))
				.build();
	}
}
