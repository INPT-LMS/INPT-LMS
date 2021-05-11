package inpt.lms.stockage.authorization;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.when;

import java.util.List;
import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import feign.RetryableException;
import inpt.lms.stockage.controller.exceptions.UnauthorizedException;
import inpt.lms.stockage.proxies.ProxyUnavailableException;
import inpt.lms.stockage.proxies.course.GestionCoursProxy;
import inpt.lms.stockage.proxies.course.Member;
import inpt.lms.stockage.proxies.publication.GestionPublicationProxy;
import inpt.lms.stockage.proxies.publication.Publication;

@ExtendWith(MockitoExtension.class)
class AuthorizationServiceTests {
	@Mock
	public GestionPublicationProxy publicationProxy;
	
	@Mock
	public GestionCoursProxy coursProxy;
	
	@InjectMocks
	public AuthorizationService authService;
	
	public UUID fakeCourseId = UUID.randomUUID();
	public Member fakeMember;
	public Publication fakePublication;
	
	@BeforeEach
	void setup() {
		fakeMember = new Member();
		fakeMember.setMemberID(7l);
		
		fakePublication = new Publication();
		fakePublication.setId("fakePub");
		fakePublication.setIdCours(fakeCourseId.toString());
		fakePublication.setIdProprietaire("7");
	}
	
	@Test
	void testClassMemberShouldNotThrow() {
		when(coursProxy.getCourseMembers(fakeCourseId)).thenReturn(
				List.of(fakeMember));
		assertDoesNotThrow(() -> authService.isClassMember(fakeCourseId, 7l));
	}
	
	@Test
	void testClassMemberShouldThrowUnauthorized() {
		when(coursProxy.getCourseMembers(fakeCourseId)).thenReturn(
				List.of(fakeMember));
		assertThrows(UnauthorizedException.class,
				() -> authService.isClassMember(fakeCourseId, 8l));
	}
	
	@Test
	void testClassMemberShouldThrowProxyUnavailable() {
		when(coursProxy.getCourseMembers(fakeCourseId))
			.thenThrow(RetryableException.class);
		assertThrows(ProxyUnavailableException.class,
				() -> authService.isClassMember(fakeCourseId, 8l));
	}
	
	@Test
	void testClassOwnerShouldNotThrow() {
		when(coursProxy.getCourseProfessor(fakeCourseId, 7l)).thenReturn(
				"7");
		assertDoesNotThrow(() -> authService.isClassOwner(fakeCourseId, 7l));
	}
	
	@Test
	void testClassMemberOrOwnerShouldNotThrow() {
		when(coursProxy.getCourseMembers(fakeCourseId)).thenReturn(
				List.of(fakeMember));
		when(coursProxy.getCourseProfessor(fakeCourseId, 8l)).thenReturn(
				"8");
		assertDoesNotThrow(() -> authService.isClassMemberOrOwner(fakeCourseId, 8l));
	}
	
	@Test
	void testPubClassMemberOrOwnerShouldNotThrow() {
		when(publicationProxy.getPublication("fakePub"))
				.thenReturn(fakePublication);
		when(coursProxy.getCourseMembers(fakeCourseId)).thenReturn(
				List.of(fakeMember));
		when(coursProxy.getCourseProfessor(fakeCourseId, 8l)).thenReturn(
				"8");
		assertDoesNotThrow(() -> authService.isPublicationClassMemberOrOwner("fakePub", 8l));
	}
}
