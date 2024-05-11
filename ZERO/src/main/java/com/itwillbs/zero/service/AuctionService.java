package com.itwillbs.zero.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.itwillbs.zero.mapper.*;
import com.itwillbs.zero.vo.*;

@Service
public class AuctionService {
	
	@Autowired
	private AuctionMapper mapper;

	// 입찰 예정 목록 조회
	public List<HashMap<String, String>> selectPreAuctionList(int pageNum, String category, String sort, int startRow, int listLimit) {
		return mapper.selectPreAuctionList(pageNum, category, sort, startRow, listLimit);
	}
	
	// 경매중 목록 조회
	public List<HashMap<String, String>> selectNowAuctionList(int pageNum, String category, String sort, int startRow,
			int listLimit) {
		return mapper.selectNowAuctionList(pageNum, category, sort, startRow, listLimit);
	}

	// 경매종료 목록 조회
	public List<HashMap<String, String>> selectEndAuctionList(int pageNum, String category, String sort, int startRow,
			int listLimit) {
		return mapper.selectEndAuctionList(pageNum, category, sort, startRow, listLimit);
	}

	// 전체 게시물 수 계산 (type으로 목록 구분)
	public int getAucionListCount(int pageNum, String category, String sort, String type) {
		return mapper.selectGetAuctionListCount(pageNum, category, sort, type);
	}

	
	
	
	// 검색시 옥션 목록 조회 (경진)
	public List<HashMap<String, String>> getAuctionList(String productSearchKeyword) {
		// TODO Auto-generated method stub
		return mapper.selectAuctionList(productSearchKeyword);
	}
	// 검색시 옥션 목록 개수 조회 (경진)
	public int getAucionCount(String productSearchKeyword) {
		// TODO Auto-generated method stub
		return mapper.selectAuctionCount(productSearchKeyword);
	}

	// 세션아이디로 현재 진행중인 경매에 참여한 결과가 있는지 확인
	public List<Map<String, String>> getPartAuction(String member_id) {
		return mapper.getPartAuction(member_id);
	}

	// 세션아이디로 낙찰받은 경매물품이 있는지 확인
	public List<Map<String, String>> getSuccessBid(String member_id) {
		return mapper.getSuccessBid(member_id);
	}
	
}
