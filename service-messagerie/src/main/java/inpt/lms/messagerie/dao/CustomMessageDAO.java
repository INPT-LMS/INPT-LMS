package inpt.lms.messagerie.dao;

import java.util.List;

public interface CustomMessageDAO {
	List<String> getAllDiscussionsWithNewMessage(long idDestinataire);
}
