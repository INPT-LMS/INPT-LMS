package inpt.lms.stockage.business.interfaces.exceptions;

public class FileTooBigException extends Exception {
	/**
	 * 
	 */
	private static final long serialVersionUID = 237516867032041958L;
	public FileTooBigException(long maxSize) {
		super(String.format("max size : %d MB",maxSize));
	}

}
