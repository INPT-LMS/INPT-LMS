package com.inpt.lms.servicegestioncomptes.repository;

import com.inpt.lms.servicegestioncomptes.model.UserInfos;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserInfosRepository extends JpaRepository<UserInfos,Long> {
}
