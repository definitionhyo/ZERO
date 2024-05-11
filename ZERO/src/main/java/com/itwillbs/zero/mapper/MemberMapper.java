package com.itwillbs.zero.mapper;

import java.util.Map;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.*;

import com.itwillbs.zero.vo.CsVO;
import com.itwillbs.zero.vo.MemberReviewVO;
import com.itwillbs.zero.vo.MemberVO;
import com.itwillbs.zero.vo.OrderSecondhandVO;
import com.itwillbs.zero.vo.SecondhandVO;

@Mapper
public interface MemberMapper {
	// mapper 설정을 위해 임의로 만듦! - 지영

	// 회원가입
	int insertMember(MemberVO member);

	// 조건에 따라 회원정보 조회 - 파라미터2개 - 수정
	Map<String, String> selectMemberCheck(@Param("column") String column, @Param("value") String value);
	
	// 회원정보 조회 리스트 - 파라미터2개 - 수정
	List<Map<String, String>> selectMemberCheckList(@Param("column") String column, @Param("value") String value);

	// 세션 아이디와 동일한 회원 정보 변경 - 수정
	int updateMemberImage(@Param("column1")String column1, @Param("member_id")String member_id, @Param("column2")String column2, @Param("value2")String value2);
// 회원정보조회(혜진)
MemberVO selectMember(String member_id);

// 계좌인증 완료한 회원의 member_bank_auth를 'Y'로 수정(혜진)
int updateBankAuth(String member_id);

	// 회원정보 조인해서 가져오기 - 수정
	Map<String, String> selectMemberJoin(@Param("column1")String column1, @Param("member_id")String member_id);

	// 회원정보 조인하고 조건절로 가져오기 - 수정
	Map<String, String> selectMemberJoin(String column1, String value1, String column2, String value2);

	// 아이디 중복 체크 (카카오 로그인에서도 사용 - 값이 있으면 > 0)
	int idCheck(String member_id);

	// 닉네임 중복 체크 
	int nickCheck(String member_nickname);

	// 핸드폰 중복 체크 
	int phoneCheck(String member_phone);


	// 회원정보 조인해서 중고 판매 거래 목록 가져오기 - 수정
	List<Map<String, String>> selectSecondhandList(String member_id);

	// 회원정보 조인해서 중고 거래 후기 목록 가져오기 - 수정
	List<Map<String, String>> selectSecondhandReviewList(String member_id);
	
	// 회원정보 조인해서 옥션 판매 거래 목록 가져오기 - 수정
	List<Map<String, String>> selectSellAuctionList(String member_id);
	
	// 회원별 찜 목록 가져오기 - 수정
	List<Map<String, String>> selectLikeList(String member_id);

	// 중고 구매내역 3개 
	List<OrderSecondhandVO> selectMyOdShList(@Param("member_id") String member_id
			, @Param("startRow") int startRow
			, @Param("listLimit") int listLimit);

//	Map으로 하면 order_secondhand_date 값 = [unread] 다음에수정하기 
//	List<Map<String, Object>> selectMyOdShList(@Param("member_id") String member_id
//												, @Param("startRow") int startRow
//												, @Param("listLimit") int listLimit);

	// 중고 판매 3개
	List<SecondhandVO> selectMyShList(@Param("member_id") String member_id
			, @Param("startRow") int startRow
			, @Param("listLimit") int listLimit);
	
	// 회원 계좌등록 여부 확인
	MemberVO selectBankAuth(String member_id);

	// 리뷰 등록
	int insertShReview(MemberReviewVO review 
					   , @Param("review_reader_id") String review_reader_id
					   , @Param("review_writer_id") String review_writer_id
					   , @Param("order_secondhand_idx") int order_secondhand_idx
					   , @Param("member_review_rating") int member_review_rating
					   , @Param("member_review_content") String member_review_content);

	// 중고거래 z맨 배달중 여부 확인
	int selectSecondhandSeller(String member_id);
	
	// 중고거래 z맨 배달중 여부 확인
	int selectSecondhandBuyer(String member_id);

	// 옥션거래 현재 참여중인지 여부 확인
	int selectAuctionSeller(String member_id);

	// 옥션거래 현재 참여중인지 여부 확인
	int selectAuctionBuyer(String member_id);

	// 대표 주소록 추가 
	int updateMainAddress(@Param("add_num")String add_num, @Param("map") Map<String, String> map);

	// 주소록 추가
	int updateAddress(@Param("add_num")String add_num, @Param("map") Map<String, String> map);

	// 주소록 삭제
	int deleteAddress(@Param("rmv")String rmv, @Param("map") Map<String, String> map);

	// 주소록 변경
	int modifyAddress(Map<String, String> map);

	// 리뷰 작성했는지 확인
	int selectWriteReview(@Param("member_id") String member_id, @Param("order_secondhand_idx") Integer order_secondhand_idx);

	// 리뷰 가져오기
	List<Map<String, String>> selectReview(String member_id);

	// 리뷰 삭제하기
	int deleteReview(@Param("member_id") String member_id, @Param("order_secondhand_idx") String order_secondhand_idx);
	
	// 나의 문의 내역 조회 - 회원 아이디로 레코드 조회
	List<CsVO> selectMyInq(String member_id);
	
	// 나의 문의 조회 - 회원 아이디로 레코드 조회
	List<CsVO> selectMyInqList(
								@Param("member_id") String member_id 
								, @Param("startRow") int startRow
								, @Param("listLimit") int listLimit);

	// 나의 문의 상세 조회 - cs_num으로 레코드 조회
	List<CsVO> selectMyInquiryDetail(String cs_idx);

	// 나의 문의 내역 - 수정
	int updateMyInqList(CsVO cs);
	
	// 나의 문의 내역 삭제 - cs_num 으로 레코드 조회 후 삭제
	int deleteMyInq(String cs_idx);

	// 이메일과 휴대폰 번호가 일치하는 회원 정보 조회
	Map<String, String> isCheckIdPhone(Map<String, String> map);

	// 임시 비밀번호로 회원정보 변경
	int updateMemberPasswd(Map<String, String> result);
	
}