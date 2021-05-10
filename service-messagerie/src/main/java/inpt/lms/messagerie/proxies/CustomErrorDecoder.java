package inpt.lms.messagerie.proxies;

import feign.Response;
import feign.codec.ErrorDecoder;

public class CustomErrorDecoder implements ErrorDecoder {

	@Override
	public Exception decode(String methodKey, Response response) {
		switch (response.status()) {
			case 404:
				return new NoSuchUserException();
			case 500:
				return new ProxyUnavailableException();
			default:
				return new Default().decode(methodKey, response); 
		}
	}
}
