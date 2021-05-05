package inpt.lms.messagerie.dao;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import inpt.lms.messagerie.model.Discussion;

@Repository
public interface DiscussionDAO extends PagingAndSortingRepository<Discussion, String> {
	
	Optional<Discussion> findOneByIdParticipant1AndIdParticipant2(long idParticipant1,
			long idParticipant2);
	
	Page<Discussion> findAllByIdParticipant1OrIdParticipant2(long idParticipant1,
			long idParticipant2,Pageable pageable);
	
	

}
