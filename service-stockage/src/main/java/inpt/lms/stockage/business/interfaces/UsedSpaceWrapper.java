package inpt.lms.stockage.business.interfaces;

public class UsedSpaceWrapper {
	protected long usedSpace;
	protected long totalSpace;
	
	public UsedSpaceWrapper() {}
	
	public UsedSpaceWrapper(long usedSpace, long availableSpace) {
		this.usedSpace = usedSpace;
		this.totalSpace = availableSpace;
	}

	public long getUsedSpace() {
		return usedSpace;
	}

	public void setUsedSpace(long usedSpace) {
		this.usedSpace = usedSpace;
	}

	public long getTotalSpace() {
		return totalSpace;
	}

	public void setTotalSpace(long availableSpace) {
		this.totalSpace = availableSpace;
	}
	

}
