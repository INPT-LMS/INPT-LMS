package com.inpt.lms.servicedevoirs.repository;

import com.inpt.lms.servicedevoirs.model.Devoir;
import com.inpt.lms.servicedevoirs.model.Fichier;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FichierRepository extends MongoRepository<Fichier,String> {
}
