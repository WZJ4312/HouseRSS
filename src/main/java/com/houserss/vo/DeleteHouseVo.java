package com.houserss.vo;

public class DeleteHouseVo {

	private int id;
	
	private int userId;
	
	private int houseId;
	
	private String houseTitle;
	
	private String deleteDate;

	public DeleteHouseVo() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getHouseId() {
		return houseId;
	}

	public void setHouseId(int houseId) {
		this.houseId = houseId;
	}

	public String getHouseTitle() {
		return houseTitle;
	}

	public void setHouseTitle(String houseTitle) {
		this.houseTitle = houseTitle;
	}

	public String getDeleteDate() {
		return deleteDate;
	}

	public void setDeleteDate(String deleteDate) {
		this.deleteDate = deleteDate;
	}

	public DeleteHouseVo(int id, int userId, int houseId, String houseTitle, String deleteDate) {
		super();
		this.id = id;
		this.userId = userId;
		this.houseId = houseId;
		this.houseTitle = houseTitle;
		this.deleteDate = deleteDate;
	}
	
	
}
