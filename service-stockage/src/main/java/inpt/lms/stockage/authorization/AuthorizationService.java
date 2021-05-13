package inpt.lms.stockage.authorization;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import feign.RetryableException;
import inpt.lms.stockage.controller.exceptions.UnauthorizedException;
import inpt.lms.stockage.proxies.ProxyUnavailableException;
import inpt.lms.stockage.proxies.course.GestionCoursProxy;
import inpt.lms.stockage.proxies.course.Member;
import inpt.lms.stockage.proxies.publication.GestionPublicationProxy;
import inpt.lms.stockage.proxies.publication.Publication;

//TODO : refactoring
@Service
public class AuthorizationService {
	@Autowired
	protected GestionCoursProxy coursProxy;
	@Autowired
	protected GestionPublicationProxy publicationProxy;

	public void isClassMember(UUID coursId, long userId) 
			throws UnauthorizedException,ProxyUnavailableException{
		try {
			List<Member> members = coursProxy.getCourseMembers(coursId);
			if (members.stream()
					.noneMatch(member -> member.getMemberID() == userId))
				throw new UnauthorizedException();
		} catch (RetryableException e) {
			throw new ProxyUnavailableException();
		}
	}
	
	public void isClassOwner(UUID coursId, long userId)
			throws UnauthorizedException,ProxyUnavailableException{
		try {
			String response = coursProxy.getCourseProfessor(coursId, userId);
			if (!response.equals(String.valueOf(userId)))
				throw new UnauthorizedException();
		} catch (RetryableException e) {
			throw new ProxyUnavailableException();
		}
	}
	
	public void isClassMemberOrOwner(UUID coursId, long userId) 
			throws UnauthorizedException,ProxyUnavailableException{
		try {
			isClassMember(coursId, userId);
		} catch (RetryableException e) {
			throw new ProxyUnavailableException();
		} catch (Exception e) {
			isClassOwner(coursId, userId);
		}
	}

	public void isPublicationOwner(String publicationId, long userId)
			throws UnauthorizedException,ProxyUnavailableException{
		try {
			String pubOwnerId = publicationProxy.getPublication(publicationId)
					.getIdProprietaire();
			if (!pubOwnerId.equals(String.valueOf(userId)))
				throw new UnauthorizedException();
		} catch (RetryableException e) {
			throw new ProxyUnavailableException();
		}
	}

	public void isPublicationClassMemberOrOwner(String publicationId, long userId) 
			throws UnauthorizedException, ProxyUnavailableException {
		try {
			Publication publication = 
					publicationProxy.getPublication(publicationId);
			String coursId = publication.getIdCours();
			String pubOwnerId = publication.getIdProprietaire();
			if (!pubOwnerId.equals(String.valueOf(userId)))
				isClassMemberOrOwner(UUID.fromString(coursId), userId);
		} catch (RetryableException e) {
			throw new ProxyUnavailableException();
		}
	}
}
