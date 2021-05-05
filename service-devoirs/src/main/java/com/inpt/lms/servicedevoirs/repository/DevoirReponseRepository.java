package com.inpt.lms.servicedevoirs.repository;

import com.inpt.lms.servicedevoirs.model.DevoirInfos;
import com.inpt.lms.servicedevoirs.model.DevoirReponse;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DevoirReponseRepository extends MongoRepository<DevoirReponse,String> {
}
