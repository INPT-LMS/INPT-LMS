package inpt.lms.messagerie.model;

import java.time.LocalDateTime;

import org.springframework.data.annotation.Id;

/**
 * Represente une discussion entre 2 participants
 * Par convention idParticipant1 < idParticipant2
 */
public class Discussion {
	@Id
	protected String id;
	protected String nomParticipant1;
	protected long idParticipant1;
	protected String nomParticipant2;
	protected long idParticipant2;
	protected Message lastMessage;
	protected LocalDateTime lastUpdate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public long getIdParticipant1() {
		return idParticipant1;
	}
	public void setIdParticipant1(long idParticipant1) {
		this.idParticipant1 = idParticipant1;
	}
	public long getIdParticipant2() {
		return idParticipant2;
	}
	public void setIdParticipant2(long idParticipant2) {
		this.idParticipant2 = idParticipant2;
	}
	public Message getLastMessage() {
		return lastMessage;
	}
	public void setLastMessage(Message lastMessage) {
		this.lastMessage = lastMessage;
	}
	public LocalDateTime getLastUpdate() {
		return lastUpdate;
	}
	public void setLastUpdate(LocalDateTime lastUpdate) {
		this.lastUpdate = lastUpdate;
	}
	public String getNomParticipant1() {
		return nomParticipant1;
	}
	public void setNomParticipant1(String nomParticipant1) {
		this.nomParticipant1 = nomParticipant1;
	}
	public String getNomParticipant2() {
		return nomParticipant2;
	}
	public void setNomParticipant2(String nomParticipant2) {
		this.nomParticipant2 = nomParticipant2;
	}
}
