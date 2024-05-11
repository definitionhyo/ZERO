package com.itwillbs.zero.controller;

import java.util.*;

import javax.servlet.http.*;

import org.json.*;
import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import com.itwillbs.zero.handler.*;
import com.itwillbs.zero.service.*;

// 알람 관련 기능들
@Controller
public class AlarmController {
	private static final Logger logger = LoggerFactory.getLogger(ChattingHandler.class);
	
	@Autowired
	private AlarmService service;
	
	@RequestMapping(value = "shortAlarmList", method = {RequestMethod.GET, RequestMethod.POST})
	public String shortAlarmList(HttpSession session) {
		
		return "alarm/alarm_list";
//		return "alarm/alarm_list_sse";
	}
	
	// 보내는 알림 DB에 넣기
	@ResponseBody
	@RequestMapping(value = "alarmRemember", method = {RequestMethod.GET, RequestMethod.POST})
	public void alarmRemember(@RequestParam Map<String, String> map) {
		
		// 보내는 알림을 DB에 넣기
		// 파라미터 map안에 member_id, alarm_message, alarm_link
		boolean isInsert = service.insertAlarm(map);
		logger.info("*** 알람 INSERT : " + isInsert);
		
	}
	
	// 받은 알림 보여주기
	@ResponseBody
	@RequestMapping(value = "alarmCheck", method = {RequestMethod.GET, RequestMethod.POST})
	public List<HashMap<String, Object>> alarmCheck(@RequestParam Map<String, String> map) {
		
		// 받은 파라미터 중에 type이 '새알림'이면 알림 내용(6개) 담아오기
		List<HashMap<String, Object>> alarmMap = service.getAlarmListNew(map);
		logger.info("*** 알람 리스트 alarmMap : " + alarmMap);
		
		return alarmMap;
	}
	
	// 알람 클릭 시 파라미터로 링크를 받아 알람 읽음 업데이트 후 링크로 이동하기
	@GetMapping("alarmClick")
	public String alarmClick(HttpSession session, String url) {
		String member_id = (String) session.getAttribute("member_id");
		String link = url.replace("--", "?");
		
		// 세션아이디와 link로 알림 조회 후 상태를 'Y'로 바꾸기
		boolean isRead = service.changeAlarmStatus(member_id, link);
		logger.info("*** 알람 읽음으로 변경 isRead : " + isRead);
		
		return "redirect:/" + link;
	}
	
	// 알림 더보기 클릭 시 가는 페이지
	@GetMapping("alarmAll")
	public String alarmAll(HttpSession session, Model model) {
		// 세션 확인
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", "로그인이 필요한 작업입니다!");
			return "fail_back";
		}
		
		// 알림 카테고리
		List<String> categories = service.getCategory();
		logger.info("*** 카테고리들 categories : " + categories);
		
		model.addAttribute("categories", categories);
		
		return "alarm/alarm_list_all";
	}
	
	@ResponseBody
	@PostMapping("alarmList")
	public String alarmList(
			@RequestParam(defaultValue = "1") int pageNum
			, @RequestParam(defaultValue = "") String category
			, HttpSession session) {
		
		String member_id = (String) session.getAttribute("member_id");
		
		// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
		int listLimit = 15; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
		// -------------------------------------------------------------------------
		// ALARM 테이블에서 3개월 전부터 오늘까지 받은 알림 보여주기
		// 파라미터 페이징 파라미터, 카테고리		리턴타입 List<HashMap>(alarmList)
		List<HashMap<String, String>> alarmList =  service.getAlarmList(member_id, pageNum, category, startRow, listLimit);
		logger.info(alarmList.toString());
		// -------------------------------------------------------------------------
		int listCount = service.getAlarmCount(member_id, pageNum, category);
//		System.out.println("전체 게시물 수 : " + listCount);
//				
		// 2. 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
//		System.out.println("전체 페이지 목록 갯수 : " + maxPage);
		// => 이것도 리턴값으로 들고가고 싶다 => 객체로 넣기(boardList = XX, maxPage = xx) => JSONObject
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("alarmList", alarmList);
		jsonObject.put("maxPage", maxPage);
		jsonObject.put("listCount", listCount);
//		System.out.println(jsonObject);
		
		return jsonObject.toString();
	}
	
	
}
