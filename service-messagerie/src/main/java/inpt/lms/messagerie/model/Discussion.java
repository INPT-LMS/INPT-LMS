package inpt.lms.messagerie.model;

import org.springframework.data.annotation.Id;

/**
 * Represente une discussion entre 2 participants
 * Par convention idParticipant1 < idParticipant2
 */
public class Discussion {
	@Id
	protected String id;
	protected long idParticipant1;
	protected long idParticipant2;
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
}
