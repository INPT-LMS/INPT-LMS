package inpt.lms.messagerie.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import inpt.lms.messagerie.model.Message;

@Repository
public interface MessageDAO extends PagingAndSortingRepository<Message, String>,
	CustomMessageDAO {
	
	Page<Message> findAllByIdDiscussion(String idDiscussion, Pageable page);

	Page<Message> findAllByIdDiscussionAndLuAndIdDestinataire(
			String idDiscussion, boolean lu,long idDestinataire, Pageable pagination);
}
