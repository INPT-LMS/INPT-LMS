package inpt.lms.stockage.forms;

import javax.validation.constraints.NotNull;

public class ParamAssocId {
	@NotNull
	protected Long assocId;
	public ParamAssocId() {}
	public ParamAssocId(Long assocId) {
		this.assocId = assocId;
	}
	public Long getAssocId() {
		return assocId;
	}

	public void setAssocId(Long assocId) {
		this.assocId = assocId;
	}
	
}
