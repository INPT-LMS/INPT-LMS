package inpt.lms.stockage.controller;

import java.io.IOException;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import inpt.lms.stockage.business.interfaces.exceptions.FileTooBigException;
import inpt.lms.stockage.business.interfaces.exceptions.NotFoundException;
import inpt.lms.stockage.business.interfaces.exceptions.StorageLimitExceededException;

@RestControllerAdvice
public class StockageControllerAdvice {
	@ExceptionHandler(NotFoundException.class)
	@ResponseStatus(code = HttpStatus.NOT_FOUND)
	public ResponseEntity<String> handleNotFound(NotFoundException e){
		return new ResponseEntity<>(e.getNotFound(), HttpStatus.NOT_FOUND);
	}
	
	@ExceptionHandler(FileTooBigException.class)
	@ResponseStatus(code = HttpStatus.BAD_REQUEST)
	public ResponseEntity<String> handleTooBigException(FileTooBigException e){
		return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
	}
	
	@ExceptionHandler(IOException.class)
	@ResponseStatus(code = HttpStatus.INTERNAL_SERVER_ERROR)
	public ResponseEntity<String> handleIOException(IOException e){
		return new ResponseEntity<>("Servor error : retry later",
				HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@ExceptionHandler(StorageLimitExceededException.class)
	@ResponseStatus(code = HttpStatus.BAD_REQUEST)
	public ResponseEntity<String> handleTooBigException(StorageLimitExceededException e){
		return new ResponseEntity<>("No space left in user storage", HttpStatus.BAD_REQUEST);
	}
}
