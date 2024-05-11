package com.itwillbs.zero.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.zero.mapper.ZmanMapper;
import com.itwillbs.zero.vo.ZmanVO;

@Service
public class ZmanService {
	
	@Autowired
	private ZmanMapper mapper;
	
	// ZMAN 회원가입
	public int registZman(ZmanVO zman, String vehiclesStr, String zman_area) {
		return mapper.insertZman(zman, vehiclesStr, zman_area);
	}
	
	// ZMAN조회
	public ZmanVO getZman(String member_id) {
		return mapper.selectZman(member_id);
	}

}
