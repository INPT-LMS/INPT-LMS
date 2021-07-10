package inpt.lms.stockage.controller.exceptions;

import java.util.List;

public class InvalidFileTypeException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4549038755366091677L;
	public InvalidFileTypeException(List<String> supportedTypes) {
		super("Supported mime types are : "+supportedTypes.toString());
	}
	public InvalidFileTypeException(String expected, String real) {
		super("Expected : "+expected+" but got : "+real);
	}
}
