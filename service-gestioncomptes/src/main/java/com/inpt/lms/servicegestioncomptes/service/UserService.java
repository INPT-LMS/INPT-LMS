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
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class UserService {

    private final PasswordEncoder passwordEncoder;
    private final UserRepository userRepository;
    private final UserInfosRepository userInfosRepository;
    private final JWTUtil jwtUtil;

    public UserInfosDTO getUserInfos(Long id) throws UserNotFoundException {
        User user = userRepository.findById(id).orElseThrow(()-> new UserNotFoundException("User not found"));
        UserInfos userInfos = user.getUserInfos();

        UserInfosDTO userInfosDTO = new UserInfosDTO();
        userInfosDTO.setEmail(user.getEmail());
        userInfosDTO.setNom(userInfos.getNom());
        userInfosDTO.setPrenom(userInfos.getPrenom());
        userInfosDTO.setLangue(userInfos.getLangue());
        userInfosDTO.setEstProfesseur(userInfos.isEstProfesseur());
        userInfosDTO.setEnseigneA(userInfos.getEnseigneA());
        userInfosDTO.setEtudieA(userInfos.getEtudieA());

        return userInfosDTO;
    }

    public User createUser(UserInfosDTO userInfosDTO) throws UserAlreadyExistsException {
        // On vérifie si un utilisateur avec le même email n'existe pas déjà
        boolean userExists =  userRepository.findByEmail(userInfosDTO.getEmail()).isPresent();
        if(userExists){
            throw new UserAlreadyExistsException("User already exists");
        }

        UserInfos userInfos = new UserInfos();
        userInfos.setNom(userInfosDTO.getNom());
        userInfos.setPrenom(userInfosDTO.getPrenom());
        userInfos.setEstProfesseur(userInfosDTO.isEstProfesseur());
        userInfos.setEnseigneA(userInfosDTO.getEnseigneA());
        userInfos.setEtudieA(userInfosDTO.getEtudieA());
        userInfos.setLangue(userInfosDTO.getLangue());

        User user = new User();
        user.setEmail(userInfosDTO.getEmail());
        user.setPassword(encryptPassword(userInfosDTO.getPassword()));

        user.setUserInfos(userInfos);
        userRepository.save(user);
        userInfosRepository.save(userInfos);

        return user;
    }

    public String loginUser(UserCredentialsDTO userCredentials) throws UserNotFoundException, BadCredentialsException{
        User user = userRepository.findByEmail(userCredentials.getEmail()).orElseThrow(()-> new UserNotFoundException("User not found"));
        return verifyPassword(userCredentials.getPassword(),user);
    }

    public void updateUser(Long userId, Long id, UserInfosDTO userInfosDTO) throws UserNotFoundException,IllegalAccessError {
        if(!userId.equals(id)){
            throw new IllegalAccessError("You can't perform this action");
        }
        User user = userRepository.findById(id).orElseThrow(()-> new UserNotFoundException("User not found"));

        // TODO Faire une meilleure mise à jour
        // Mise à jour des infos de l'utilisateur
        UserInfos userInfos = user.getUserInfos();
        userInfos.setNom(userInfosDTO.getNom());
        userInfos.setPrenom(userInfosDTO.getPrenom());
        userInfos.setEstProfesseur(userInfosDTO.isEstProfesseur());
        userInfos.setEnseigneA(userInfosDTO.getEnseigneA());
        userInfos.setEtudieA(userInfosDTO.getEtudieA());
        userInfos.setLangue(userInfosDTO.getLangue());

        // Mise à jour des credentials aussi
        user.setEmail(userInfosDTO.getEmail());
        user.setPassword(encryptPassword(userInfosDTO.getPassword()));

        userRepository.save(user);
        userInfosRepository.save(userInfos);
    }

    public void deleteUser(Long userId, Long id) throws UserNotFoundException,IllegalAccessError {
        if(!userId.equals(id)){
            throw new IllegalAccessError("You can't perform this action");
        }

        User user = userRepository.findById(id).orElseThrow(()-> new UserNotFoundException("User not found"));
        UserInfos userInfos = user.getUserInfos();

        userRepository.delete(user);
        userInfosRepository.delete(userInfos);
    }

    public String encryptPassword(String password){
        return passwordEncoder.encode(password);
    }

    public String verifyPassword(String password,User user){
        String encryptedPassword = user.getPassword();
        if(passwordEncoder.matches(password,encryptedPassword)){
            return jwtUtil.generateToken(user.getUserInfos());
        }else {
            throw new BadCredentialsException("Invalid email or password");
        }
    }


}
