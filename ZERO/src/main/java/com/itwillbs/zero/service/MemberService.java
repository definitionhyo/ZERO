package com.itwillbs.zero.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.itwillbs.zero.mapper.MemberMapper;
import com.itwillbs.zero.vo.CsVO;
import com.itwillbs.zero.vo.MemberReviewVO;
import com.itwillbs.zero.vo.MemberVO;
import com.itwillbs.zero.vo.OrderSecondhandVO;
import com.itwillbs.zero.vo.SecondhandVO;

@Service
public class MemberService {
	
	@Autowired
	private MemberMapper mapper;
	
	// 회원가입
	public int registMember(MemberVO member) {
		return mapper.insertMember(member);
	}

	// id로 회원정보 조회
	public Map<String, String> isMemberCheck(String column, String email) {
		return mapper.selectMemberCheck(column, email);
	}
	
	// id로 회원정보목록 조회
	public List<Map<String, String>> isMemberCheckList(String column, String email) {
		return mapper.selectMemberCheckList(column, email);
	}

	// 세션 id 와 동일한 회원의 프로필 이미지 업데이트
	public int updateMember(String column1, String member_id, String column2, String fileName1) {
		
		return mapper.updateMemberImage(column1, member_id, column2, fileName1);
	}

	// 회원 정보 조회(혜진)
	public MemberVO getMember(String member_id) {
		return mapper.selectMember(member_id);
	}
	
	// 계좌인증 완료한 회원의 member_bank_auth를 'Y'로 수정(혜진)
	public int modifyBankAuth(String member_id) {
		return mapper.updateBankAuth(member_id);
	}

	// 계좌정보 조회
	public Map<String, String> selectMemberInfo(String column, String member_id) {
		return mapper.selectMemberJoin(column, member_id);
	}

	// 회원가입 폼 - 아이디 중복확인 메서드 
	public int idCheck(String member_id) {
		int cnt = mapper.idCheck(member_id);
		System.out.println("cnt : " + cnt);
		return cnt;
	}

	// 회원가입 폼 - 닉네임 중복확인 메서드 
	public int nickCheck(String member_nickname) {
		int cnt = mapper.nickCheck(member_nickname);
		System.out.println("cnt : " + cnt);
		return cnt;
	}

	// 회원가입 폼 - 핸드폰 중복확인 메서드 
	public int phoneCheck(String member_phone) {
		int cnt = mapper.phoneCheck(member_phone);
		return cnt;
	}


	// 중고 거래 목록 가져오기
	public List<Map<String, String>> selectSecondhandList(String member_id) {
		return mapper.selectSecondhandList(member_id);
	}

	// 마이페이지 메인 - 중고상품구매내역 최신순 3개 가져오기
	public List<OrderSecondhandVO> getMyOdShList(String member_id, int startRow, int listLimit) {
		return mapper.selectMyOdShList(member_id, startRow, listLimit);
	}
//	Map으로 하면 order_secondhand_date 값 = [unread] 다음에수정하기 
//	public List<Map<String, Object>> getMyOdShList(String member_id, int startRow, int listLimit) {
//		return mapper.selectMyOdShList(member_id, startRow, listLimit);
//	}

	// 마이페이지 메인 - 판매(중)내역 최신순 3개 가져오기
	public List<SecondhandVO> getmyShList(String member_id, int startRow, int listLimit) {
		return mapper.selectMyShList(member_id, startRow, listLimit);
	}


	// 회원아이디로 중고 상품 판매 후기 리스트 조회
	public List<Map<String, String>> selectsellReviewList(String member_id) {
		// TODO Auto-generated method stub
		return mapper.selectSecondhandReviewList(member_id);
	}

	// 회원아이디로 경매 판매 리스트 조회
	public List<Map<String, String>> selectAuctionList(String member_id) {
		// TODO Auto-generated method stub
		return mapper.selectSellAuctionList(member_id);
	}

	// 회원아이디로 찜 목록 리스트 조회
	public List<Map<String, String>> selectLikeList(String member_id) {
		// TODO Auto-generated method stub
		return mapper.selectLikeList(member_id);
	}

	// 회원 계좌 등록 확인
	// 회원 탈퇴시 체크
	public boolean withDrawalCheck(String member_id) {
		
		int isSecondhandSeller = 0; // 중고거래 시 z맨으로 배달중인지 여부
		int isSecondhandBuyer = 0; // 중고거래 시 z맨으로 배달중인지 여부
		int isAuctionSeller = 0; // 옥션거래 시 경매중인지 여부
		int isAuctionBuyer = 0; // 옥션거래 시 경매중인지 여부
		
		isSecondhandSeller = mapper.selectSecondhandSeller(member_id);
		isSecondhandBuyer = mapper.selectSecondhandBuyer(member_id);
		isAuctionSeller = mapper.selectAuctionSeller(member_id);
		isAuctionBuyer = mapper.selectAuctionBuyer(member_id);
		
		System.out.println("isSecondhandSeller:" + isSecondhandSeller);
		System.out.println("isSecondhandBuyer:" + isSecondhandBuyer);
		System.out.println("isAuctionSeller:" + isAuctionSeller);
		System.out.println("isAuctionBuyer:" + isAuctionBuyer);
		if(0 == isSecondhandSeller + isSecondhandBuyer + isAuctionSeller + isAuctionBuyer ) { // 없으면 탈퇴 가능
			return true;
		}
		return false; // 있으면 탈퇴 불가
	}

	public MemberVO isValidBank(String member_id) {
		return mapper.selectBankAuth(member_id);
	}

	// 회원 중고상품 리뷰 등록
	public int writeShReview(MemberReviewVO review, String review_reader_id, String review_writer_id, int order_secondhand_idx, int member_review_rating, String member_review_content) {
		return mapper.insertShReview(review, review_reader_id, review_writer_id, order_secondhand_idx, member_review_rating, member_review_content);
	}

	// 회원 대표 주소록 추가(add_num : 주소록 번호) - 수정
	public int addMainAddress(String add_num, Map<String, String> map) {
		return mapper.updateMainAddress(add_num, map);
	}
	
	// 회원 주소록 추가(add_num : 주소록 번호) - 수정
	public int addAddress(String add_num, Map<String, String> map) {
		return mapper.updateAddress(add_num, map);
	}

	// 회원 주소록 변경 - 수정
	public int reWriteAddress(Map<String, String> map) {
		return mapper.modifyAddress(map);
		
	}

	// 회원 주소록 삭제(rmv2 : 주소2만 삭제 , rew2_rmv3 : 주소3을 2로 업데이트 후 주소3삭제, rmv : 주소3 삭제) - 수정
	public int deleteAddress(String rmv, Map<String, String> map) {
		return mapper.deleteAddress(rmv, map);
		
	}

	// 멤버 아이디로 리뷰 썻는지 확인 member_id = review_writer_id
	public Map<Integer, Integer> getWriteReviewStatus(String member_id, List<Integer> orderSecondhandIdxList) {
	    Map<Integer, Integer> resultMap = new HashMap<>();
	    for (Integer order_secondhand_idx : orderSecondhandIdxList) {
	        int isWriteReview = mapper.selectWriteReview(member_id, order_secondhand_idx);
	        resultMap.put(order_secondhand_idx, isWriteReview);
	    }
	    return resultMap;
	}
	
	// 작성한 리뷰 가져오기
	public List<Map<String, String>> getReview(String member_id) {
		return mapper.selectReview(member_id);
	}

	// 작성한 리뷰 삭제
	public int deleteReview(String member_id, String order_secondhand_idx) {
		return mapper.deleteReview(member_id, order_secondhand_idx);
	}



	// 마이페이지 - 회원 나의 문의 페이지 조회
	public List<CsVO> getMyInqList(String member_id, int startRow, int listLimit) {
		return mapper.selectMyInqList(member_id, startRow, listLimit);
	}
	
	// 마이페이지 - 회원 나의 문의 내역 상세 조회
	public List<CsVO> getMyInquiryDetail(String cs_num) {
		return mapper.selectMyInquiryDetail(cs_num);
	}
	
	// 마이페이지 - 회원 나의 문의 내역 수정 
	public int updateMyInqList(CsVO cs) {
		return mapper.updateMyInqList(cs);
	}

	// 마이페이지 - 회원 나의 문의 내역 삭제
	public int deleteMyInquiry(String cs_num) {
		return mapper.deleteMyInq(cs_num);
	}

	// 아이디와 비밀번호가 일치하는 회원 조회
	public Map<String, String> isCheckIdPhone(Map<String, String> map) {
		return mapper.isCheckIdPhone(map);
	}

	// 임시 비밀번호 저장
	public int updateMemberPasswd(Map<String, String> result) {
		return mapper.updateMemberPasswd(result);
	}
	
}
