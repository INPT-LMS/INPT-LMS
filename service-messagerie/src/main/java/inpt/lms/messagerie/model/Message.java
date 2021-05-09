package inpt.lms.messagerie.model;

import java.time.LocalDateTime;

import org.springframework.data.annotation.Id;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonProperty.Access;

public class Message {
	@Id
	protected String id;
	protected String idDiscussion;
	protected long idEmetteur;
	protected long idDestinataire;
	protected LocalDateTime date;
	protected String contenu;
	@JsonProperty(access = Access.WRITE_ONLY) 
	protected boolean lu;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public long getIdEmetteur() {
		return idEmetteur;
	}
	public void setIdEmetteur(long idEmetteur) {
		this.idEmetteur = idEmetteur;
	}
	public long getIdDestinataire() {
		return idDestinataire;
	}
	public void setIdDestinataire(long idDestinataire) {
		this.idDestinataire = idDestinataire;
	}
	public LocalDateTime getDate() {
		return date;
	}
	public void setDate(LocalDateTime date) {
		this.date = date;
	}
	public String getContenu() {
		return contenu;
	}
	public void setContenu(String contenu) {
		this.contenu = contenu;
	}
	public boolean isLu() {
		return lu;
	}
	public void setLu(boolean lu) {
		this.lu = lu;
	}
	public String getIdDiscussion() {
		return idDiscussion;
	}
	public void setIdDiscussion(String idDiscussion) {
		this.idDiscussion = idDiscussion;
	}
	
}
