package com.lms.servicepublications.repository;

import com.lms.servicepublications.model.Like;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LikeRepository extends MongoRepository<Like, String> {
    boolean existsByIdProprietaire(String idPublication);
}
