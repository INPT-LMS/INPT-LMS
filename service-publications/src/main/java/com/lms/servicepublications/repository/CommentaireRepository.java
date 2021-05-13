package com.lms.servicepublications.repository;

import com.lms.servicepublications.model.Commentaire;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentaireRepository extends MongoRepository<Commentaire, String> {
}
