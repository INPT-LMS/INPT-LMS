package inpt.lms.messagerie.forms;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class MessageForm {
	@NotNull
	protected Long idDestinataire;
	@Size(min = 1)
	@NotNull
	protected String contenu;
	public Long getIdDestinataire() {
		return idDestinataire;
	}
	public void setIdDestinataire(Long idDestinataire) {
		this.idDestinataire = idDestinataire;
	}
	public String getContenu() {
		return contenu;
	}
	public void setContenu(String contenu) {
		this.contenu = contenu;
	}
	
	
}
