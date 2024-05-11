package com.itwillbs.zero.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.zero.vo.AuctionManagingVO;
import com.itwillbs.zero.vo.CsVO;
import com.itwillbs.zero.vo.MemberVO;
import com.itwillbs.zero.vo.OrderSecondhandVO;
import com.itwillbs.zero.vo.ReportVO;
import com.itwillbs.zero.vo.SecondhandVO;
import com.itwillbs.zero.vo.ZeroAccountHistoryVO;
import com.itwillbs.zero.vo.ZmanDeliveryVO;
import com.itwillbs.zero.vo.ZmanVO;
import com.itwillbs.zero.vo.ZpayHistoryVO;
import com.itwillbs.zero.vo.ZpayVO;

@Mapper
public interface AdminMapper {


	// 회원 목록 조회
	List<MemberVO> selectMemberList();

	// 회원 정보 조회
	MemberVO selectMember(int member_idx);
	
	// 회원관리 - 회원 정보 삭제
	int deleteMemebr(int member_idx);
	
	// 회원관리 - 회원 정보 수정
	int updateMember(MemberVO member);

	// 회원관리 - 회원 신고 목록 조회
	List<ReportVO> selectMemberReportList(String reported_member_id);

	// 회원관리 - 회원 신고 정보 조회
	ReportVO selectMemberReportDetail(int report_idx);

	// 회원관리 - 회원 피신고 건수 조회
	int selectMemberReportCount(String member_id);

	// 회원관리 - 회원 신고 정보 수정(처리상태 변경)
	int updateMemberReport(ReportVO report);
	
	//  ========== ========== zman 관리  ========== ==========
	// zman 관리 - zmna 목록 조회
	List<ZmanVO> selectZmanList();
	
	// zman 관리 - zmna 정보 조회
	ZmanVO selectZman(int zman_idx);
	
	// zman관리 - zman 정보 삭제
	int deleteZamn(int zman_idx);
	
	// zman관리 - zman 정보 수정
	int updateZman(ZmanVO zman);
	
	//  zman관리 - ZMNA 상태가 '활동'으로 변경되면 MEMBER.member_type 'Z맨'으로 변경
	int updateZmanMemberType(String zman_id);
	
	// zman 관리 - 배달 내역 목록 조회
	List<ZmanDeliveryVO> selectDeliveryList();

	// zman 관리 - zman 배달 내역 상세 조회 
	ZmanDeliveryVO selectDeliveryDetail(int zman_delivery_idx);
	
	// zman관리 - zman 신고 내역 조회
	List<ReportVO> selectZmanReportList();
	
	// zman관리 - zman 신고 상세 페이지로 이동
	ReportVO selectZmanReportDetail(int report_idx);
	
	// ========== ========== 중고거래 관리  ========== ==========
	// 중고거래관리 - 중고거래 목록 페이지로 이동
	List<SecondhandVO> selectSecondhandManagingList();
	
	// 중고거래관리 - 중고 거래 상품 상세 보기 페이지로 이동
	Map<String, String> selectSecondhandManagingDetail(int secondhand_idx);
	
	// 중고거래관리 - 중고거래 등록 상품 삭제 
	int deleteSecondhandItem(int secondhand_idx);

	// 중고거래관리 - 중고거래 주문(ORDER) 목록 페이지로 이동
	List<SecondhandVO> selectOrderSecondhandList(String member_id);

	// 중고거래관리 - 중고거래 주문(ORDER) 상세 페이지로 이동
	Map<String, String> selectOrderSecondhandDetail(@Param("order_secondhand_idx") int order_secondhand_idx, @Param("order_secondhand_type") String order_secondhand_type);

	// ========== ========== 경매 관리  ========== ==========
	
	// 경매관리 - 경매예정 상품 목록 조회
	List<AuctionManagingVO> selectAuctionManagingList();
	
	// 경매관리 - 경매예정 상품 정보 조회
	Map<String, String> selectAuctionManaging(int auction_idx);

	// 경매관리 - 경매예정 상품 정보 수정
	int updateAuctionManaging(AuctionManagingVO auctionManaging);
	
	// 경매관리 - 경매 상품 목록 페이지로 디스패치
	List<AuctionManagingVO> selectAuctionProductList();

	// 경매관리 - 경매 상품 상세보기
	Map<String, String> selectAuctionProduct(int auction_idx);

	// 경매관리 - 경매 내역 목록 조회
	List<Map<String, String>> selectOrderAutionList(String member_id);
	

	// 경매관리 - 경매 거래 내역 상세보기
	Map<String, String> selectAuctionOrder(int order_auction_idx);
	
	//  ========== ========== 고객센터 관리  ========== ==========
	// 고객센터관리 - 공지사항 목록 조회
	List<CsVO> selectCsList();

	// 고객센터관리 - 공지사항 '관리자'인지 확인
	String selectAdminMember(String member_id);

	// 고객센터관리 - 공지사항 글쓰기
	int insertNotice(CsVO cs);
	
	// 고객센터관리 - 공지사항 글 정보 조회
	CsVO selectCs(int cs_idx);

	// 고객센터관리 - 공지사항 글수정
	int updateNotice(CsVO cs);
	
	// 고객센터관리 - 공지사항 글삭제
	int deleteNotice(int cs_idx);

	// 고객센터관리 - 1:1 문의 게시판 조회하기
	List<CsVO> selectCsQnAList();

	// 고객센터관리 - 1:1 문의 게시판 상세 페이지로 이동하기
	CsVO selectCsQnADetail(@Param("cs_idx") int cs_idx, @Param("cs_info_idx") int cs_info_idx);

	// 고객센터 관리 - 1:1 문의 답변 등록하기
	int updateReplyQnA(CsVO cs);

	// 고객센터 관리 - 1:1 문의 답변 수정하기
	int updateReplyModifyQnA(CsVO cs);

	// 고객센터 관리 - 1:1 문의글 삭제하기
	int deleteQnA(int cs_idx);
	
	// 고객센터 관리 - 자주 묻는 질문 게시판 조회하기
	List<CsVO> selectFaQ();
	
	// 고객센터 관리 - 자주 묻는 질문 등록하기
	int insertFaQ(CsVO cs);

	// 고객센터 관리 - 자주 묻는 질문 상세페이지로 이동하기
	CsVO selectFaQDetail(@Param("cs_idx") int cs_idx, @Param("cs_info_idx") int cs_info_idx);

	// 고객센터 관리 - 자주 묻는 질문 수정하기
	int updateFaq(CsVO cs);

	// 고객센터 관리 - 자주 묻는 질문 삭제하기
	int deleteFaq(int cs_idx);

	
	// ========================= ZPAY 관리 ===============================================================================
	// ZPAY 관리 - 충전/환급 목록 조회
	List<ZpayHistoryVO> selectZpayDepositWithdrawList();

	// ZPAY 관리 - 충전/환급 정보 조회
	ZpayHistoryVO selectZpayDepositWithdraw(int zpay_history_idx);

	// ZPAY 관리 - 사용/수익 목록 조회
	List<ZpayHistoryVO> selectZpayUseList();

	// ZPAY 관리 - 사용/수익 정보 조회
	ZpayHistoryVO selectZpayUse(int zpay_history_idx);

	// 계좌 관리 - 약정 계좌 내역 목록 조회
	List<ZeroAccountHistoryVO> selectZeroAccountHistoryList();
	
	// ZERO_ACCOUNT_HISTORY 잔액조회
	Integer selectZeroAccountBalance();

	// 계좌 관리 - 회원 계좌 목록 조회
	List<ZpayVO> selectMemberZpayList();

	// 계좌 관리 - 회원 계좌 거래 정보 조회
	List<ZpayHistoryVO> selectMemberZpayHistoryList(int zpay_idx);

	// 계좌 관리 - ZMAN 계좌 목록 조회
	List<ZpayVO> selectZmanZpayList();

	
	// =============================================================================================================
	Map<String, String> selectDealRatio();

	List<Map<String, String>> selectDatilyDealCount();

	List<Map<String, String>> selectDailDealAmount();

	List<Map<String, String>> selectDailyMemberRegistCount();


	


















	



	









}
