package inpt.lms.stockage.business.interfaces;

public class UsedSpaceWrapper {
	protected long usedSpace;
	protected long availableSpace;
	
	public UsedSpaceWrapper() {}
	
	public UsedSpaceWrapper(long usedSpace, long availableSpace) {
		this.usedSpace = usedSpace;
		this.availableSpace = availableSpace;
	}

	public long getUsedSpace() {
		return usedSpace;
	}

	public void setUsedSpace(long usedSpace) {
		this.usedSpace = usedSpace;
	}

	public long getAvailableSpace() {
		return availableSpace;
	}

	public void setAvailableSpace(long availableSpace) {
		this.availableSpace = availableSpace;
	}
	

}
