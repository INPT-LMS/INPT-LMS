package com.inpt.lms.servicegestioncomptes.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.inpt.lms.servicegestioncomptes.dto.UserCredentialsDTO;
import com.inpt.lms.servicegestioncomptes.dto.UserInfosDTO;
import com.inpt.lms.servicegestioncomptes.exception.UserAlreadyExistsException;
import com.inpt.lms.servicegestioncomptes.exception.UserNotFoundException;
import com.inpt.lms.servicegestioncomptes.model.User;
import com.inpt.lms.servicegestioncomptes.service.UserService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
public class UserController {

    private final UserService userService;
    private final ObjectMapper objectMapper;

    @PostMapping("/auth")
    public ResponseEntity<ObjectNode> loginUser(@RequestBody UserCredentialsDTO userCredentials){
        String token = null;
        ObjectNode objectNode = objectMapper.createObjectNode();
        try {
            token = userService.loginUser(userCredentials);
        } catch (UserNotFoundException e) {
            objectNode.put("error",e.getMessage());
            return new ResponseEntity<>(objectNode,HttpStatus.NOT_FOUND);
        } catch (BadCredentialsException e) {
            objectNode.put("error",e.getMessage());
            return new ResponseEntity<>(objectNode,HttpStatus.UNAUTHORIZED);
        }
        objectNode.put("message","User logged in").put("userToken",token);
        return new ResponseEntity<>(objectNode,HttpStatus.OK);
    }

    @PostMapping("/register")
    public ResponseEntity<ObjectNode> createUser(@RequestBody UserInfosDTO userInfosDTO){
        User user = null;
        ObjectNode objectNode = objectMapper.createObjectNode();
        try {
           user = userService.createUser(userInfosDTO);
        } catch (UserAlreadyExistsException e) {
            objectNode.put("error",e.getMessage());
            return new ResponseEntity<>(objectNode, HttpStatus.CONFLICT);
        }
        objectNode.put("message","User created").put("userId",user.getId());
        return new ResponseEntity<>(objectNode, HttpStatus.OK);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<ObjectNode> updateUser(@RequestHeader(name = "X-USER-ID") Long userId, @PathVariable Long id,@RequestBody UserInfosDTO userInfosDTO) {
        ObjectNode objectNode = objectMapper.createObjectNode();
        try {
            userService.updateUser(id,userInfosDTO);
        } catch (UserNotFoundException e) {
            objectNode.put("error",e.getMessage());
            return new ResponseEntity<>(objectNode,HttpStatus.NOT_FOUND);
        }
        objectNode.put("message","User updated");
        return new ResponseEntity<>(objectNode, HttpStatus.OK);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<ObjectNode> deleteUser(@RequestHeader(name = "X-USER-ID") Long userId, @PathVariable Long id){
        ObjectNode objectNode = objectMapper.createObjectNode();
        try {
            userService.deleteUser(id);
        } catch (UserNotFoundException e) {
            objectNode.put("error",e.getMessage());
            return new ResponseEntity<>(objectNode,HttpStatus.NOT_FOUND);
        }
        objectNode.put("message","User updated");
        return new ResponseEntity<>(objectNode, HttpStatus.OK);

    }
}
