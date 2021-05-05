package inpt.lms.messagerie.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import inpt.lms.messagerie.business.interfaces.exceptions.NotFoundException;

@RestControllerAdvice
public class MessagerieControllerAdvice {
	@ExceptionHandler(NotFoundException.class)
	@ResponseStatus(code = HttpStatus.NOT_FOUND)
	public ResponseEntity<String> handleNotFoundException(NotFoundException e){
		return new ResponseEntity<>("Discussion not found",
				HttpStatus.NOT_FOUND);
	}
}
