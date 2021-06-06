package inpt.lms.stockage.proxies;

import feign.Response;
import feign.codec.ErrorDecoder;
import inpt.lms.stockage.business.interfaces.exceptions.NotFoundException;
import inpt.lms.stockage.controller.exceptions.UnauthorizedException;

public class CustomErrorDecoder implements ErrorDecoder {

	@Override
	public Exception decode(String methodKey, Response response) {
		switch (response.status()) {
			case 404:
				return methodKey.equals("GestionCompteProxy#getUserInfos(long)") ?
						new NotFoundException("user") :new UnauthorizedException();
			case 500:
				return new ProxyUnavailableException();
			default:
				return new Default().decode(methodKey, response); 
		}
	}
}