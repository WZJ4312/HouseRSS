package com.houserss.dao;

import java.util.List;

import com.houserss.pojo.DeleteHouse;

public interface DeleteHouseMapper {

	void insert(DeleteHouse deleteHouse);
	
	List<DeleteHouse> getByUserId(int userId);
	
	DeleteHouse get(int id);
	
	void deleterById(int id);
}
