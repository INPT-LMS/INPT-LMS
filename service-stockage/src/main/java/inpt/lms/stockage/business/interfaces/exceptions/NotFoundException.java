package inpt.lms.stockage.business.interfaces.exceptions;

public class NotFoundException extends Exception{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7798806419502529557L;
	protected final String notFound;
	
	public NotFoundException(String notFound) {
		super("Introuvable : "+notFound);
		this.notFound = notFound;
	}
	
	public String getNotFound() {
		return notFound;
	}
}
