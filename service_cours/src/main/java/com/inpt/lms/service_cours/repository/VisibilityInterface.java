package com.inpt.lms.service_cours.repository;

import com.inpt.lms.service_cours.model.Visibility;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VisibilityInterface extends JpaRepository<Visibility, Integer> {
}
