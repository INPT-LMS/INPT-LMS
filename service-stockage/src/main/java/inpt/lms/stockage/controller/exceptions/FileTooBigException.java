package inpt.lms.stockage.controller.exceptions;

public class FileTooBigException extends Exception {
	/**
	 * 
	 */
	private static final long serialVersionUID = 237516867032041958L;
	public FileTooBigException(long maxSize) {
		super("configured maximum size : "+maxSize);
	}

}
