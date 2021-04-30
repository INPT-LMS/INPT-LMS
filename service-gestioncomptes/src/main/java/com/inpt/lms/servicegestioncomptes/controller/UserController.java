package com.inpt.lms.servicegestioncomptes.controller;

import com.inpt.lms.servicegestioncomptes.dto.UserCredentialsDTO;
import com.inpt.lms.servicegestioncomptes.dto.UserInfosDTO;
import com.inpt.lms.servicegestioncomptes.service.UserService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
public class UserController {

    private final UserService userService;

    @PostMapping("/auth")
    public ResponseEntity<String> loginUser(@RequestBody UserCredentialsDTO userCredentials) {
        userService.loginUser(userCredentials);
        // TODO return a token
        return new ResponseEntity<>("User logged in", HttpStatus.OK);
    }

    @PostMapping("/register")
    public ResponseEntity<String> createUser(@RequestBody UserInfosDTO userInfosDTO){
        userService.createUser(userInfosDTO);
        return new ResponseEntity<>("User created", HttpStatus.OK);
    }

    // TODO Verify is user is authorized
    @PutMapping("/update/{id}")
    public ResponseEntity<String> updateUser(@PathVariable Long id,@RequestBody UserInfosDTO userInfosDTO){
        userService.updateUser(id,userInfosDTO);
        return new ResponseEntity<>("User updated", HttpStatus.OK);
    }

    // TODO Verify is user is authorized
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteUser(@PathVariable Long id){
        userService.deleteUser(id);
        return new ResponseEntity<>("User deleted", HttpStatus.OK);
    }
}
