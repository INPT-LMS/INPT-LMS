package inpt.lms.messagerie.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import inpt.lms.messagerie.business.interfaces.exceptions.NotFoundException;
import inpt.lms.messagerie.proxies.NoSuchUserException;
import inpt.lms.messagerie.proxies.ProxyUnavailableException;

@RestControllerAdvice
public class MessagerieControllerAdvice {
	@ExceptionHandler(NotFoundException.class)
	@ResponseStatus(code = HttpStatus.NOT_FOUND)
	public ResponseEntity<String> handleNotFoundException(NotFoundException e){
		return new ResponseEntity<>("Discussion not found",
				HttpStatus.NOT_FOUND);
	}
	
	@ExceptionHandler(NoSuchUserException.class)
	@ResponseStatus(code = HttpStatus.BAD_REQUEST)
	public ResponseEntity<String> handleNotFoundException(NoSuchUserException e){
		return new ResponseEntity<>("No user with idDestinataire",
				HttpStatus.BAD_REQUEST);
	}
	
	@ExceptionHandler(ProxyUnavailableException.class)
	@ResponseStatus(code = HttpStatus.SERVICE_UNAVAILABLE)
	public ResponseEntity<String> handleProxyUnvailableException(
			ProxyUnavailableException e){
		return new ResponseEntity<>("Server error please retry later",
				HttpStatus.SERVICE_UNAVAILABLE);
	}
}
