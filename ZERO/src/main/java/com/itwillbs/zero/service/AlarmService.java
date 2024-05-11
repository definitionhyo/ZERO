package com.itwillbs.zero.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.itwillbs.zero.mapper.*;

@Service
public class AlarmService {
	
	@Autowired
	private AlarmMapper mapper;
	
	// 보내는 알람을 DB에 넣기
	public boolean insertAlarm(Map<String, String> map) {
		int insertCount = mapper.insertAlarm(map);
		if(insertCount > 0) {
			return true;
		}
		return false;
	}
	
	// 알림 내용 담아오기
	public List<HashMap<String, Object>> getAlarmListNew(Map<String, String> map) {
		return mapper.selectAlarmListNew(map);
	}

	// 세션아이디와 link로 알림 조회 후 상태를 'Y'로 바꾸기
	public boolean changeAlarmStatus(String member_id, String link) {
		return mapper.updateAlarmStatus(member_id, link);
	}
	
	// 알림 카테고리들 들고오기
	public List<String> getCategory() {
		return mapper.selectAlarmCategory();
	}

	// ALARM 테이블에서 3개월 전부터 오늘까지 받은 알림 보여주기
	public List<HashMap<String, String>> getAlarmList(String member_id, int pageNum, String category, int startRow, int listLimit) {
		return mapper.selectAlarmList(member_id, pageNum, category, startRow, listLimit);
	}

	// 알람 총 갯수
	public int getAlarmCount(String member_id, int pageNum, String category) {
		return mapper.selectAlarmCount(member_id, pageNum, category);
	}
	
	
}
