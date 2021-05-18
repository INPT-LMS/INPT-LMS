package com.lms.servicepublications.repository;

import com.lms.servicepublications.model.Publication;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface PublicationRepository extends MongoRepository<Publication, String> {
    List<Publication> findByidCoursOrderByDatePublicationDesc(UUID idCours);
    Publication findPublicationByid(String idPublication);

}
