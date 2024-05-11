package com.itwillbs.zero.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

@Mapper
public interface AlarmMapper {

	// 보내는 알람을 DB에 넣기
	int insertAlarm(Map<String, String> map);

	// 알림 내용 담아오기
	List<HashMap<String, Object>> selectAlarmListNew(Map<String, String> map);

	// 세션아이디와 link로 알림 조회 후 상태를 'Y'로 바꾸기
	boolean updateAlarmStatus(@Param("member_id") String member_id, @Param("link") String link);

	// 알림 카테고리들 들고오기
	List<String> selectAlarmCategory();
	
	// ALARM 테이블에서 3개월 전부터 오늘까지 받은 알림 보여주기
	List<HashMap<String, String>> selectAlarmList(@Param("member_id") String member_id, @Param("pageNum") int pageNum, @Param("category") String category
											, @Param("startRow") int startRow, @Param("listLimit") int listLimit);
	
	// 알람 총 갯수
	int selectAlarmCount(@Param("member_id") String member_id, @Param("pageNum") int pageNum, @Param("category") String category);

}
