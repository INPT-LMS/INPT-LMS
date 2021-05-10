package com.inpt.lms.servicegestioncomptes.service;

import com.inpt.lms.servicegestioncomptes.dto.UserCredentialsDTO;
import com.inpt.lms.servicegestioncomptes.dto.UserInfosDTO;
import com.inpt.lms.servicegestioncomptes.exception.UserAlreadyExistsException;
import com.inpt.lms.servicegestioncomptes.exception.UserNotFoundException;
import com.inpt.lms.servicegestioncomptes.model.User;
import com.inpt.lms.servicegestioncomptes.model.UserInfos;
import com.inpt.lms.servicegestioncomptes.repository.UserInfosRepository;
import com.inpt.lms.servicegestioncomptes.repository.UserRepository;
import com.inpt.lms.servicegestioncomptes.util.JWTUtil;
import lombok.AllArgsConstructor;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.Optional;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.verify;

class UserServiceTest {
    private UserService underTest;

    @Mock
    private UserRepository userRepository;
    @Mock
    private UserInfosRepository userInfosRepository;
    @Mock
    private JWTUtil jwtUtil;
    @Mock
    private PasswordEncoder passwordEncoder;

    @BeforeEach
    void setUp(){
        MockitoAnnotations.openMocks(this);
        underTest = new UserService(passwordEncoder,userRepository,userInfosRepository,jwtUtil);
    }

    @Test
    @DisplayName("It should login an existing User")
    void itShouldLoginAUser() throws UserNotFoundException {
        // Given
        String email = "amine@gmail.com";
        String password = "123456";
        String encPassword = "654321";

        given(passwordEncoder.encode(password)).willReturn(encPassword);

        User user = new User();
        user.setEmail(email);
        user.setPassword(encPassword);

        UserCredentialsDTO userCredentialsDTO = new UserCredentialsDTO();
        userCredentialsDTO.setEmail(email);
        userCredentialsDTO.setPassword(password);

        given(userRepository.findByEmail(user.getEmail())).willReturn(Optional.of(user));
        given(passwordEncoder.matches(password,encPassword)).willReturn(true);

        // When
        underTest.loginUser(userCredentialsDTO);

        // Then
        verify(userRepository).findByEmail(email);
    }

    @Test
    @DisplayName("It should create User and UserInfos objects from UserInfosDTO")
    void itShouldCreateUserAndUserInfosFromUserInfosDTO() throws UserAlreadyExistsException {
        // Given
        UserInfosDTO userInfosDTO = new UserInfosDTO();
        userInfosDTO.setEmail("amine@gmail.com");
        userInfosDTO.setPassword("123456");
        userInfosDTO.setNom("Rachyd");
        userInfosDTO.setPrenom("Amine");
        userInfosDTO.setEnseigneA("INPT");
        userInfosDTO.setEtudieA("INPT");
        userInfosDTO.setLangue("FR");
        userInfosDTO.setEstProfesseur(true);


        UserInfos userInfos = new UserInfos();
        userInfos.setNom("Rachyd");
        userInfos.setPrenom("Amine");
        userInfos.setEnseigneA("INPT");
        userInfos.setEtudieA("INPT");
        userInfos.setLangue("FR");
        userInfos.setEstProfesseur(true);

        User user = new User();
        user.setEmail("amine@gmail.com");
        user.setPassword(underTest.encryptPassword("123456"));

        user.setUserInfos(userInfos);
        //userInfos.setUser(user);

        // When
        underTest.createUser(userInfosDTO);

        // Then
        ArgumentCaptor<User> userArgumentCaptor = ArgumentCaptor.forClass(User.class);
        ArgumentCaptor<UserInfos> userInfosArgumentCaptor = ArgumentCaptor.forClass(UserInfos.class);

        verify(userRepository).save(userArgumentCaptor.capture());
        verify(userInfosRepository).save(userInfosArgumentCaptor.capture());

        User capturedUser = userArgumentCaptor.getValue();
        UserInfos capturedUserInfos = userInfosArgumentCaptor.getValue();

        assertThat(capturedUser).isEqualTo(user);
        assertThat(capturedUserInfos).isEqualTo(userInfos);
        assertThat(capturedUserInfos).isEqualTo(capturedUser.getUserInfos());
    }

    @Test
    @DisplayName("It should update an existing User and his UserInfos")
    void itShouldUpdateAnExistingUserAndHisUnderInfos() throws UserNotFoundException {
        // Given
        Long id = 1l;
        Long userId=1l;

        UserInfosDTO userInfosDTO = new UserInfosDTO();
        userInfosDTO.setEmail("amine@gmail.com");
        userInfosDTO.setPassword("123456");
        userInfosDTO.setNom("Rachyd");
        userInfosDTO.setPrenom("Amine");
        userInfosDTO.setEnseigneA("INPT");
        userInfosDTO.setEtudieA("INPT");
        userInfosDTO.setLangue("FR");
        userInfosDTO.setEstProfesseur(true);

        User user = new User();
        UserInfos userInfos = new UserInfos();
        user.setUserInfos(userInfos);

        given(userRepository.findById(id)).willReturn(Optional.of(user));

        // When
        underTest.updateUser(userId, id,userInfosDTO);

        // Then
        verify(userRepository).save(user);
        verify(userInfosRepository).save(user.getUserInfos());
    }

    @Test
    @DisplayName("It should delete an existing User and his UserInfos")
    void itShouldDeleteAnExistingUserAndHisUserInfos() throws UserNotFoundException {
        // Given
        Long id = 1l;
        Long userInfosId = 1l;
        Long userId=1l;

        User user = new User();
        UserInfos userInfos = new UserInfos();
        user.setUserInfos(userInfos);

        given(userRepository.findById(id)).willReturn(Optional.of(user));
        given(userInfosRepository.findById(userInfosId)).willReturn(Optional.of(userInfos));

        // When
        underTest.deleteUser(userId,id);

        // Then
        verify(userRepository).delete(user);
        verify(userInfosRepository).delete(userInfos);
    }
}