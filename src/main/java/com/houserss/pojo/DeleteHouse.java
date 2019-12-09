package com.houserss.pojo;

public class DeleteHouse {

	private Integer id;
	
	private Integer userId;
	
	private Integer houseId;
	
	private String deleteDate;

	public DeleteHouse() {
		super();
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getHouseId() {
		return houseId;
	}

	public void setHouseId(Integer houseId) {
		this.houseId = houseId;
	}

	public String getDeleteDate() {
		return deleteDate;
	}

	public void setDeleteDate(String deleteDate) {
		this.deleteDate = deleteDate;
	}

	public DeleteHouse(Integer id, Integer userId, Integer houseId, String deleteDate) {
		super();
		this.id = id;
		this.userId = userId;
		this.houseId = houseId;
		this.deleteDate = deleteDate;
	}
	
}
