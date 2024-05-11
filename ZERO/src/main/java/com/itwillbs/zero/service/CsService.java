package com.itwillbs.zero.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.zero.mapper.CsMapper;
import com.itwillbs.zero.vo.CsVO;

@Service
public class CsService {

	@Autowired
	private CsMapper mapper;
	
	// CsMain.jsp -  공지사항 목록 조회
	public List<CsVO> getCsListMain() {
		return mapper.selectNoticeListMain();
	}

	// 공지사항 - 페이징 계산작업
	// 전체게시물 수 조회 작업 요청
	public int getNoticeListCount() {
		return mapper.selectNoticeListCount();
	}
	
	// 공지사항 목록 조회
	public List<CsVO> getCsList(int startRow, int listLimit) {
		return mapper.selectNoticeList(startRow, listLimit);
	}
	
	// 자주 묻는 질문 조회
	public List<CsVO> getCsFaq(String cs_type) {
		return mapper.selectCsFaq(cs_type);
	}

	// 1:1 문의글 등록하기 (csQnaFormPro)
	public int registCsQnaform(CsVO cs) {
		return mapper.insertCsQna(cs);
	}




}
