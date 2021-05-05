package com.inpt.lms.servicegestioncomptes.service;

import com.inpt.lms.servicegestioncomptes.dto.UserCredentialsDTO;
import com.inpt.lms.servicegestioncomptes.dto.UserInfosDTO;
import com.inpt.lms.servicegestioncomptes.model.User;
import com.inpt.lms.servicegestioncomptes.model.UserInfos;
import com.inpt.lms.servicegestioncomptes.repository.UserInfosRepository;
import com.inpt.lms.servicegestioncomptes.repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final UserInfosRepository userInfosRepository;

    public boolean loginUser(UserCredentialsDTO userCredentials) {
        // TODO User not found exception
        User user = userRepository.findByEmail(userCredentials.getEmail()).orElseThrow(()-> new RuntimeException());
        return verifyPassword(userCredentials.getPassword(),user.getPassword());
    }

    public void createUser(UserInfosDTO userInfosDTO) {
        /**
         * On définit d'abord les infos de l'utilisateur
         */
        UserInfos userInfos = new UserInfos();
        userInfos.setNom(userInfosDTO.getNom());
        userInfos.setPrenom(userInfosDTO.getPrenom());
        userInfos.setEstProfesseur(userInfosDTO.isEstProfesseur());
        userInfos.setEnseigneA(userInfosDTO.getEnseigneA());
        userInfos.setEtudieA(userInfosDTO.getEtudieA());
        userInfos.setLangue(userInfosDTO.getLangue());

        /**
         * Puis on définit l'utilisateur
         */
        User user = new User();
        user.setEmail(userInfosDTO.getEmail());
        user.setPassword(encryptPassword(userInfosDTO.getPassword()));

        /**
         * On link les 2
         */
        user.setUserInfos(userInfos);
        userRepository.save(user);
        userInfosRepository.save(userInfos);
    }

    public void updateUser(Long id, UserInfosDTO userInfosDTO) {
        // TODO User not found exception
        User user = userRepository.findById(id).orElseThrow(()-> new RuntimeException());

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

    public void deleteUser(Long id) {
        User user = userRepository.findById(id).orElseThrow(()-> new RuntimeException());
        UserInfos userInfos = user.getUserInfos();

        userRepository.delete(user);
        userInfosRepository.delete(userInfos);
    }

    // TODO return an encrypted password
    private String encryptPassword(String password){
        return password;
    }

    // TODO une meilleure vérification
    private boolean verifyPassword(String password,String encryptedPassword){
        return password == encryptedPassword;
    }
}
