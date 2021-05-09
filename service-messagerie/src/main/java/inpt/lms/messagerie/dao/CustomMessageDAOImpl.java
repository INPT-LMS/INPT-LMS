package inpt.lms.messagerie.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;
import static org.springframework.data.mongodb.core.query.Criteria.where;
import static org.springframework.data.mongodb.core.query.Query.query;

import inpt.lms.messagerie.model.Message;

@Repository
public class CustomMessageDAOImpl implements CustomMessageDAO {
	@Autowired
	protected MongoTemplate template;

	@Override
	public List<String> getAllDiscussionsWithNewMessage(long idDestinataire) {
		return template.query(Message.class)
				.distinct("idDiscussion")
				.matching(query(where("idDestinataire").is(idDestinataire)))
				.matching(query(where("lu").is(false)))
				.as(String.class)
				.all();
	}

}
