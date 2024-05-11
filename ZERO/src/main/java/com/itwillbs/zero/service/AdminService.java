package com.itwillbs.zero.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.zero.mapper.AdminMapper;
import com.itwillbs.zero.vo.AuctionManagingVO;
import com.itwillbs.zero.vo.CsVO;
import com.itwillbs.zero.vo.MemberVO;
import com.itwillbs.zero.vo.OrderAuctionVO;
import com.itwillbs.zero.vo.OrderSecondhandVO;
import com.itwillbs.zero.vo.ReportVO;
import com.itwillbs.zero.vo.SecondhandVO;
import com.itwillbs.zero.vo.ZeroAccountHistoryVO;
import com.itwillbs.zero.vo.ZmanDeliveryVO;
import com.itwillbs.zero.vo.ZmanVO;
import com.itwillbs.zero.vo.ZpayHistoryVO;
import com.itwillbs.zero.vo.ZpayVO;

@Service
public class AdminService {

	@Autowired
	private AdminMapper mapper;

//  ========== ========== 회원 관리  ========== ==========
	// 회원관리 - 회원 목록 조회
	public List<MemberVO> getMemebrList() {
		return mapper.selectMemberList();
	}

	// 회원관리 - 회원 정보 조회
	public MemberVO getMember(int member_idx) {
		return mapper.selectMember(member_idx);
	}
	
	// 회원관리 - 회원 피신고 건수 조회
	public int getMemberReportCount(String member_id) {
		return mapper.selectMemberReportCount(member_id);
	}
	
	// 회원관리 - 회원 정보 삭제
	public int removeMember(int member_idx) {
		return mapper.deleteMemebr(member_idx);
	}
	
	// 회원관리 - 회원 정보 수정
	public int modifyMember(MemberVO member) {
		return mapper.updateMember(member);
	}
	
	// 회원관리 - 회원 신고 목록 조회
	public List<ReportVO> getMemberReportList(String reported_member_id) {
		return mapper.selectMemberReportList(reported_member_id);
	}
	
	// 회원관리 - 회원 신고 정보 조회
	public ReportVO getMemberReportDetail(int report_idx) {
		return mapper.selectMemberReportDetail(report_idx);
	}
	
	// 회원관리 - 회원 신고 정보 수정(처리상태 변경)
	public int modifyReport(ReportVO report) {
		return mapper.updateMemberReport(report);
	}
	
	//  ========== ========== zman 관리  ========== ==========
	// zman 관리 - zmna 목록 조회
	public List<ZmanVO> getZmanList() {
		return mapper.selectZmanList();
	}

	// zman 관리 - zmna 정보 조회
	public ZmanVO getZman(int zman_idx) {
		return mapper.selectZman(zman_idx);
	}
	
	// zman관리 - zman 정보 삭제
	public int removeZman(int zman_idx) {
		return mapper.deleteZamn(zman_idx);
	}
	
	// zman관리 - zman 정보 수정
	public int modifyZman(ZmanVO zman) {
		return mapper.updateZman(zman);
	}
	
	//  zman관리 - ZMNA 상태가 '활동'으로 변경되면 MEMBER.member_type 'Z맨'으로 변경
	public int modifyZmanMemberType(String zman_id) {
		return mapper.updateZmanMemberType(zman_id);
	}

	
	// zman 관리 - 배달 내역 목록 조회
	public List<ZmanDeliveryVO> getDeliveryList() {
		return mapper.selectDeliveryList();
	}
	
	// zman 관리 - zman 배달 내역 상세 조회 
	public ZmanDeliveryVO getDeliveryDetail(int zman_delivery_idx) {
		return mapper.selectDeliveryDetail(zman_delivery_idx);
	}

	// zman관리 - zman 신고 내역 조회
	public List<ReportVO> getZmanReportList() {
		return mapper.selectZmanReportList();
	}

	// zman관리 - zman 신고 상세 페이지로 이동
	public ReportVO getZmanReportDetail(int report_idx) {
		return mapper.selectZmanReportDetail(report_idx);
	}
	
	//  ========== ========== 중고거래 관리  ========== ==========
	// 중고거래관리 - 중고거래 목록 페이지로 이동
	public List<SecondhandVO> getsecondhandManagingList() {
		return mapper.selectSecondhandManagingList();
	}

	// 중고거래관리 - 중고 거래 상품 상세 보기 페이지로 이동
	public Map<String, String> getsecondhandManagingDetail(int secondhand_idx) {
		return mapper.selectSecondhandManagingDetail(secondhand_idx);
	}
	
	// 중고거래관리 - 중고거래 등록 상품 삭제 
	public int removeSecondhandItem(int secondhand_idx) {
		return mapper.deleteSecondhandItem(secondhand_idx);
	}
	
	// 중고거래관리 - 중고거래 주문(ORDER) 목록 페이지로 이동
	public List<SecondhandVO> getOrderSecondhandList(String member_id) {
		return mapper.selectOrderSecondhandList(member_id);
	}

	// 중고거래관리 - 중고거래 주문(ORDER) 상세 페이지로 이동
	public Map<String, String> getSecondhandOrderDetail(int order_secondhand_idx, String order_secondhand_type) {
		return mapper.selectOrderSecondhandDetail(order_secondhand_idx, order_secondhand_type);
	}
	
	//  ========== ========== 경매 관리  ========== ==========
	// 경매관리 - 경매예정 상품 목록 조회
	public List<AuctionManagingVO> getAuctionManagingList() {
		return mapper.selectAuctionManagingList();
	}
	
	// 경매관리 - 경매예정 상품 정보 조회
	public Map<String, String> getAuctionManaging(int auction_idx) {
		return mapper.selectAuctionManaging(auction_idx);
	}
	
	// 경매관리 - 경매예정 상품 정보 수정
	public int modifyAuctionManaging(AuctionManagingVO auctionManaging) {
		return mapper.updateAuctionManaging(auctionManaging);
	}
	
	// 경매관리 - 경매 상품 목록 페이지로 디스패치
	public List<AuctionManagingVO> getAuctionProductList() {
		return mapper.selectAuctionProductList();
	}

	// 경매관리 - 경매 상품 상세보기
	public Map<String, String> getAuctionProduct(int auction_idx) {
		return mapper.selectAuctionProduct(auction_idx);
	}
	
	// 경매관리 - 경매 내역 목록 조회
	public List<Map<String, String>> getAuctionOrderList(String member_id) {
		return mapper.selectOrderAutionList(member_id);
	}
	
	// 경매관리 - 경매 거래 내역 상세보기
	public Map<String, String> getAuctionOrder(int order_auction_idx) {
		return mapper.selectAuctionOrder(order_auction_idx);
	}

	
	//  ========== ========== 고객센터 관리  ========== ==========
	// 고객센터관리 - 공지사항 목록 조회
	public List<CsVO> getCsList() {
		return mapper.selectCsList();
	}
	
	// 고객센터관리 - 공지사항 '관리자'인지 확인
	public boolean isAdmin(String member_id) {
		
		if(mapper.selectAdminMember(member_id).equals("관리자")) {
			return true;
		} else {
			return false;			
		}
		
	}
	
	// 고객센터관리 - 공지사항 글쓰기
	public int registNotice(CsVO cs) {
		return mapper.insertNotice(cs);
	}
	
	// 고객센터관리 - 글 정보 조회
	public CsVO getCs(int cs_idx) {
		return mapper.selectCs(cs_idx);
	}

	// 고객센터관리 - 공지사항 글수정
	public int updateNotice(CsVO cs) {
		return mapper.updateNotice(cs);
	}
	
	// 고객센터관리 - 공지사항 글삭제
	public int removeNotice(int cs_idx) {
		return mapper.deleteNotice(cs_idx);
	}

	// 고객센터관리 - 1:1 문의 게시판 조회하기
	public List<CsVO> getCsQnAList() {
		return mapper.selectCsQnAList();
	}

	// 고객센터관리 - 1:1 문의 게시판 상세 페이지로 이동하기
	public CsVO getCsQnADetail(int cs_idx, int cs_info_idx) {
		return mapper.selectCsQnADetail(cs_idx, cs_info_idx);
	}

	// 고객센터 관리 - 1:1 문의 답변 등록하기
	public int replyCsQnADetail(CsVO cs) {
		return mapper.updateReplyQnA(cs);
	}

	// 고객센터 관리 - 1:1 문의 답변 수정하기
	public int replyModifyCsQnADetail(CsVO cs) {
		return mapper.updateReplyModifyQnA(cs);
	}
	
	// 고객센터 관리 - 1:1 문의글 삭제하기
	public int removeCsQnA(int cs_idx) {
		return mapper.deleteQnA(cs_idx);
	}

	// 고객센터 관리 - 자주 묻는 질문 게시판 조회하기
	public List<CsVO> getCsFaqList() {
		return mapper.selectFaQ();
	}

	// 고객센터 관리 - 자주 묻는 질문 등록하기
	public int registCsFaQ(CsVO cs) {
		return mapper.insertFaQ(cs);
	}

	// 고객센터 관리 - 자주 묻는 질문 상세페이지로 이동하기
	public CsVO getCsFaqDetail(int cs_idx, int cs_info_idx) {
		return mapper.selectFaQDetail(cs_idx, cs_info_idx);
	}

	// 고객센터 관리 - 자주 묻는 질문 수정하기
	public int modifyFaqDetail(CsVO cs) {
		return mapper.updateFaq(cs);
	}

	// 고객센터 관리 - 자주 묻는 질문 삭제하기
	public int removeCsFaq(int cs_idx) {
		return mapper.deleteFaq(cs_idx);
	}

	
	// ========================= ZPAY 관리 ===============================================================================
	// ZPAY 관리 - 충전/환급 목록 조회
	public List<ZpayHistoryVO> getZpayDepositWithdrawList() {
		return mapper.selectZpayDepositWithdrawList();
	}

	// ZPAY 관리 - 충전/환급 정보 조회
	public ZpayHistoryVO getZpayDepositWithdraw(int zpay_history_idx) {
		return mapper.selectZpayDepositWithdraw(zpay_history_idx);
	}

	// ZPAY 관리 - 사용/수익 목록 조회
	public List<ZpayHistoryVO> getZpayUseList() {
		return mapper.selectZpayUseList();
	}

	// ZPAY 관리 - 사용/수익 정보 조회
	public ZpayHistoryVO getZpayUse(int zpay_history_idx) {
		return mapper.selectZpayUse(zpay_history_idx);
	}

	// 계좌 관리 - 약정 계좌 내역 목록 조회
	public List<ZeroAccountHistoryVO> getZeroAccountHistoryList() {
		return mapper.selectZeroAccountHistoryList();
	}
	
	// ZERO_ACCOUNT_HISTORY 잔액조회
	public Integer getZeroAccountBalance() {
		
		Integer zero_account_balance = mapper.selectZeroAccountBalance();
		
		return zero_account_balance != null ? zero_account_balance : 0;
	}
	
	// 계좌 관리 - 회원 계좌 목록 조회
	public List<ZpayVO> getMemberZpayList() {
		return mapper.selectMemberZpayList();
	}

	// 계좌 관리 - 회원 계좌 거래 정보 조회
	public List<ZpayHistoryVO> getMemberZpayHistoryList(int zpay_idx) {
		return mapper.selectMemberZpayHistoryList(zpay_idx);
	}
	
	// 계좌 관리 - ZMAN 계좌 목록 조회
	public List<ZpayVO> getZmanZpayList() {
		return mapper.selectZmanZpayList();
	}

	
	// ===============================================================================================================
	public Map<String, String> getDealRatio() {
		return mapper.selectDealRatio();
	}

	public List<Map<String, String>> getDealCount() {
		return mapper.selectDatilyDealCount();
	}

	public List<Map<String, String>> getDealAmount() {
		return mapper.selectDailDealAmount();
	}

	public List<Map<String, String>> getDailyMemberRegistCount() {
		return mapper.selectDailyMemberRegistCount();
	}



	
	
	
	
	

	













	
	



	

	

	

	

	

	

	

		
	
}
