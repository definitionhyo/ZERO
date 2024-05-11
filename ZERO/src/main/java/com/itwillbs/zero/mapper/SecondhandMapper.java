package com.itwillbs.zero.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.itwillbs.zero.vo.*;

@Mapper
public interface SecondhandMapper {

	//중고상품 등록 작업 요청
	int insertProduct(SecondhandVO secondhand);

	//카테고리 리스트 조회 요청
	List<HashMap<String, String>> selectCategoryList();

	// 중고 목록 조회 요청
	List<SecondhandVO> selectSecondhandList(@Param("startRow") int startRow, @Param("listLimit") int listLimit);

	// 중고 목록 개수조회 요청(페이징처리)
	int selectSecondhandListCount();
	
	
	
	// 정렬변경시 정렬변경된 중고상품 목록 조회 요청
	List<HashMap<String, String>> selectChangedSecondhandList(
								@Param("pageNum") int pageNum, 
								@Param("category") String category,
								@Param("sort") String sort,
								@Param("startRow") int startRow,
								@Param("listLimit") int listLimit,
								@Param("type") String type);
	// 정렬변경시 정렬변경된 중고상품 목록개수 조회 요청
	int selectChangedSecondhandListCount(
								@Param("pageNum") int pageNum,
								@Param("category") String category, 
								@Param("sort")	String sort, 
								@Param("type") String type);
	
	
	
//	// 상품번호에 해당하는 카테고리 정보 조회요청
//	String selectCategory(int secondhand_idx);

	// 상품번호에 해당하는 상품의 상세정보조회 요청
	SecondhandVO selectProduct(int secondhand_idx);

	
	
	

	
	
	// 상품번호? member_id에 해당하는 판매자정보조회 요청
	HashMap<String, String> selectSellerInfo(@Param("secondhand_idx") int secondhand_idx,@Param("member_id") String member_id);

	// 판매자의 판매물품 개수 조회요청
	int selectSellerProductCount(String member_id);

	// 판매자의 판매물품 리스트 조회요청
	List<HashMap<String, String>> selectSellerProductList(String member_id);


	
	
	
	
	
	
	
	
	// 상품수정작업 (update)
	int updateSecondhand(SecondhandVO secondhand);

	// 상품삭제작업 (delete)
	int deleteSecondhand(int secondhand_idx);

	// 상품 상세정보 조회 -> 조회수증가작업 (update)
	void updateReadCount(SecondhandVO secondhand);

	
	
	
	//판매자페이지 ----------------------------------------------------------
	
	//판매자페이지 - 판매자정보조회요청(재사용X-member_id만 사용)
	MemberVO selectSellerInfo_sellerPage(String member_id);
	
	//판매자가 판매중, 예약중인 상품목록 조회
	List<HashMap<String, String>> selectDealProductList(String member_id);	
	//판매자의 판매완료된 상품목록 조회
	List<HashMap<String, String>> selectSoldoutProductList(String member_id);

	//판매자가 판매중, 예약중인 상품개수 조회
	int selectDealProductCount(String member_id);
	//판매자의 판매완료된 상품개수 조회
	int selectSoldOutProductCount(String member_id);

	
	//판매자페이지 - 리뷰리스트 조회요청
	List<HashMap<String,String>> selectReviewList(String member_id);
	
	//판매자페이지 - 리뷰리스트 개수조회요청
	int selectReviewCount(String member_id);
	
	//검색결과페이지------------------------------------------------------------
	
	//검색키워드 포함된 중고상품리스트 조회요청
	List<SecondhandVO> selectSearchSecondhandList(String productSearchKeyword);

	//검색키워드 포함된 중고상품 개수 조회요청
	int selectSearchSecondhandCount(String productSearchKeyword);

	
	
	
	
	
	
	//신고하기 insert 작업
	int insertReport(@Param("reportType") String reportType,
			@Param("reportReason") String reportReason,
			@Param("secondhand_idx") String secondhand_idx,
			@Param("member_id") String member_id, 
			@Param("report_member_id") String report_member_id);

	
	//찜등록기능
	int insertLikeProduct(LikeVO productLike);
	//찜취소기능
	int deleteLikeProduct(LikeVO productLike);
	//찜조회기능
	LikeVO selectLikeProduct(String member_id);

	
	//끌어올리기
	int updateDate(int secondhand_idx);

			

	
	
	
	
	

}
