package inpt.lms.stockage.authorization;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import feign.RetryableException;
import inpt.lms.stockage.controller.exceptions.UnauthorizedException;
import inpt.lms.stockage.proxies.GestionCoursProxy;
import inpt.lms.stockage.proxies.ProxyUnavailableException;

@Service
public class AuthorizationService {
	@Autowired
	protected GestionCoursProxy coursProxy;
	
	public void isClassMember(String coursId, long userId) 
			throws UnauthorizedException,ProxyUnavailableException{
		try {
			throw new UnauthorizedException();
		} catch (RetryableException e) {
			throw new ProxyUnavailableException();
		}
	}
	
	public void isClassOwner(String coursId, long userId)
			throws UnauthorizedException,ProxyUnavailableException{
		try {
			throw new UnauthorizedException();
		} catch (RetryableException e) {
			throw new ProxyUnavailableException();
		}
	}
	
	public void isClassMemberOrOwner(String coursId, long userId) 
			throws UnauthorizedException,ProxyUnavailableException{
		try {
			throw new UnauthorizedException();
		} catch (RetryableException e) {
			throw new ProxyUnavailableException();
		}
	}

	public void isPublicationOwner(String publicationId, long userId)
			throws UnauthorizedException,ProxyUnavailableException{
		try {
			throw new UnauthorizedException();
		} catch (RetryableException e) {
			throw new ProxyUnavailableException();
		}
	}

	public void isPublicationClassMemberOrOwner(String publicationId, long userId) 
			throws UnauthorizedException, ProxyUnavailableException {
		try {
			throw new UnauthorizedException();
		} catch (RetryableException e) {
			throw new ProxyUnavailableException();
		}
	}
}
