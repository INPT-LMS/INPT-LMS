package com.inpt.lms.servicedevoirs.repository;

import com.inpt.lms.servicedevoirs.model.Devoir;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface DevoirRepository extends MongoRepository<Devoir,String> {
    List<Devoir> findDevoirsByIdCours(String idCours);
}
