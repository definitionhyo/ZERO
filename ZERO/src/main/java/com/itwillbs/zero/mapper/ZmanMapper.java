package com.itwillbs.zero.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.zero.vo.ZmanVO;

@Mapper
public interface ZmanMapper {
	
	// Zman 회원가입
	int insertZman(@Param("zman") ZmanVO zman, 
				   @Param("vehiclesStr") String vehiclesStr, 
				   @Param("zman_area") String zman_area);

	// Zman 조회
	ZmanVO selectZman(String member_id);

}
