package com.inpt.lms.servicedevoirs.repository;

import com.inpt.lms.servicedevoirs.model.Devoir;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DevoirRepository extends MongoRepository<Devoir,String> {
}
