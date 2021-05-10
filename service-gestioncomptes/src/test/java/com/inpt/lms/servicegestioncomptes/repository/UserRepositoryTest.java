package com.inpt.lms.servicegestioncomptes.repository;

import com.inpt.lms.servicegestioncomptes.model.User;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import java.util.Optional;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.junit.jupiter.api.Assertions.*;

@DataJpaTest
class UserRepositoryTest {

    @Autowired
    private UserRepository underTest;

    @AfterEach
    void tearDown() {
        underTest.deleteAll();
    }

    @Test
    @DisplayName("It should find an already existing User")
    void existsByEmail() {
        // Given
        String email = "amine@gmail.com";
        User user = new User();
        user.setEmail(email);

        underTest.save(user);

        // When
        Optional<User> optional = underTest.findByEmail(email);
        boolean userIsFound = optional.isPresent();

        // Then
        assertThat(userIsFound).isTrue();
    }
}