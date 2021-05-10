package com.inpt.lms.servicedevoirs.repository;

import com.inpt.lms.servicedevoirs.model.DevoirInfos;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DevoirInfosRepository extends MongoRepository<DevoirInfos,String> {
}
