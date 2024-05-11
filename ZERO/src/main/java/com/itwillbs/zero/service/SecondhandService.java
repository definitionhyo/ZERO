package com.itwillbs.zero.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import com.itwillbs.zero.mapper.*;
import com.itwillbs.zero.vo.*;


@Service
public class SecondhandService {

	
	 @Autowired
	 private SecondhandMapper mapper;


	// 중고상품 등록 폼 - 중고 카테고리 목록
	public List<HashMap<String, String>> getCategorylist() {
		return mapper.selectCategoryList();
	}
	 
	// 중고 상품 등록작업 요청
	public int registBoard(SecondhandVO secondhand) {
		int insertcount= mapper.insertProduct(secondhand);
//		mapper.insertProduct(secondhand);
		
		return  insertcount;
	}

	
	
	// 목록페이지 --------------------------------------------------------------
	// 중고 목록 페이지
	public List<SecondhandVO> getSecondhandList(int startRow, int listLimit) {
		return mapper.selectSecondhandList(startRow, listLimit);
	}

	// 페이징처리 - 중고목록 전체 개수 
	public int getSecondhandListCount() {
		return mapper.selectSecondhandListCount();
	}

	
	
	
	// 거래중 게시물 목록조회
	public List<HashMap<String, String>> getChangedSecondhandList(int pageNum, String category, String sort,
			int startRow, int listLimit, String type) {
		
		return mapper.selectChangedSecondhandList(pageNum, category, sort, startRow, listLimit, type);
	}

	public int getChangedSecondhandListCount(int pageNum, String category, String sort, String type) {
		// TODO Auto-generated method stub
		return mapper.selectChangedSecondhandListCount(pageNum, category, sort, type);
	}
	
	
	
	
	
	
	
	
	//상세페이지 - 상품번호에 해당하는 상품정보 조회
	//수정페이지, 삭제페이지(작성자확인)에서도 재사용
	
	//조회성공시 조회수 증가
	public SecondhandVO getSecondhandProduct(int secondhand_idx) {
		
		SecondhandVO secondhand = mapper.selectProduct(secondhand_idx);
		
		//조회결과 있을경우(조회성공시 -> 조회수 증가작업요청 -> updateReadCount()
		if(secondhand != null) {
			// secondhandVO에 secondhand_idx 포함되어있으므로
			// 파라미터로 secondahndVO객체 전달시 -> 값변경되면 별도리턴없어도 주소값변경O
			//=> 사용된VO객체의 변경된 값 함께 공유!
			mapper.updateReadCount(secondhand);
		}
		
		return secondhand;
	}


	
	
	
	//상세페이지(판매자영역) - 판매자 정보 조회---------------------------------------------------
	// 판매자페이지 - 판매자 정보 조회요청(selectSellerInfo()재사용-파라미터 member_id만 사용)
	public HashMap<String,String> getSellerInfo(int secondhand_idx, String member_id) {
		System.out.println("Serviece+++++++++++++++++++++++" + secondhand_idx + " ," + member_id);
		return mapper.selectSellerInfo(secondhand_idx, member_id);
	}

	//상세페이지(판매자영역) - 판매자 판매물품 개수조회
	public int getSellerProductCount(String member_id) {
		return mapper.selectSellerProductCount(member_id);
	}
	
	
	// 판매자의 판매목록 조회요청
	public List<HashMap<String, String>> getSellerProductList(String member_id) {
		return mapper.selectSellerProductList(member_id);
	}

	
	
	

	
	
	
	
	
	
	
	
	
	//상품수정작업 
	public int modifySecondhand(SecondhandVO secondhand) {
		return mapper.updateSecondhand(secondhand);
	}

	//글삭제 - 1. 작성자 확인 작업
	public boolean isBoardWriter(int secondhand_idx, String member_id) {
		//글번호에 해당하는 작성자확인 -> 상세정보조회의 selectProduct()재사용
		//-조회된결과의 작성자id(secondhand.getMember_id()) 와, 전달받은 세션아이디 비교결과 리턴
		SecondhandVO secondhand = mapper.selectProduct(secondhand_idx);
		return secondhand.getMember_id().equals(member_id);
	}

	//글삭제 - 2. 글삭제작업
	public int removeSecondhand(int secondhand_idx) {
		return mapper.deleteSecondhand(secondhand_idx);
	}

	
	
	
	//---------------------------------------------------------------------------------------
	//판매자페이지
	
	
	// 판매자페이지(판매자탭) - 판매자 정보 조회요청(selectSellerInfo()재사용-파라미터 member_id만 사용)
	public MemberVO getSellerInfo_sellerPage(String member_id) {
		System.out.println("Serviece+++++++++++++++++++++++" + member_id);
		return mapper.selectSellerInfo_sellerPage(member_id);
	}	
	
	//판매자의 판매중/예약중 상품목록 조회
	public List<HashMap<String, String>> getdealProductList(String member_id) {
		System.out.println("거래중목록 Serviece+++++++++++++++++++++++");

		return mapper.selectDealProductList(member_id);
	}
	//판매자의 판매완료 상품목록 조회
	public List<HashMap<String, String>> getsoldOutProductList(String member_id) {
		System.out.println("거래완료목록 Serviece+++++++++++++++++++++++");

		return mapper.selectSoldoutProductList(member_id);
	}
	
	
	//판매자의 판매중/예약중 상품개수 조회
	public int getdealProductCount(String member_id) {
		System.out.println("거래중개수 Serviece+++++++++++++++++++++++");

		return mapper.selectDealProductCount(member_id);
	}
	//판매자의 판매완료 상품개수 조회
	public int getsoldOutProductCount(String member_id) {
		System.out.println("거래완료개수 Serviece+++++++++++++++++++++++");

		return mapper.selectSoldOutProductCount(member_id);
	}

	
	
	
	
	
	
	
	
	// 검색페이지 - 검색된 중고상품리스트 조회
	public List<SecondhandVO> getSearchSecondhandList(String productSearchKeyword) {
		// TODO Auto-generated method stub
		return mapper.selectSearchSecondhandList(productSearchKeyword);
	}
	// 검색페이지 - 검색된 중고상품 개수조회
	public int getSearchSecondhandCount(String productSearchKeyword) {
		// TODO Auto-generated method stub
		return mapper.selectSearchSecondhandCount(productSearchKeyword);
	}
	
	
	
	
	
	// 신고하기 insert 작업
	public int registReport(String reportType, String reportReason, String secondhand_idx, String member_id, String report_member_id) {
		
		return mapper.insertReport(reportType, reportReason, secondhand_idx, member_id, report_member_id);
	}

	
	
	// 판매자페이지 - 리뷰 조회작업
	public List<HashMap<String, String>> getReviewList(String member_id) {
		return mapper.selectReviewList(member_id);
	}
	// 판매자페이지 - 리뷰개수 카운팅
	public int getReviewListCount(String member_id) {
		return mapper.selectReviewCount(member_id);
	}

	
	
	
	// 찜하기기능 - insert
	public int checkLikeProduct(LikeVO productLike) {
		return mapper.insertLikeProduct(productLike);
	}
	// 찜취소기능 - delete
	public int unCheckLikeProduct(LikeVO productLike) {
		return mapper.deleteLikeProduct(productLike);
	}
	// 찜목록 - select
	public LikeVO getLikeProduct(String member_id) {
		return mapper.selectLikeProduct(member_id);
	}

	
	
	//끌어올리기
	public int updateRegistdate(int secondhand_idx) {
		System.out.println("(&(*&(&*&*^&(^&^(^(^& 끌어올리기 service");
		return mapper.updateDate(secondhand_idx);
	}





	
	// 상세페이지(판매자
	
	
	
	


//	// 수정페이지 - 상품번호에 해당하는 이미지정보 받아오기
//	public Map<String, String> getImageList(int secondhand_idx) {
//		
//		return null;
//	}


	    

}
