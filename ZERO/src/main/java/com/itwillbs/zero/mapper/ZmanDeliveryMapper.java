package com.itwillbs.zero.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.zero.vo.ZmanDeliveryVO;
import com.itwillbs.zero.vo.ZmanEarningVO;
import com.itwillbs.zero.vo.ZmanRefundHistoryVO;
import com.itwillbs.zero.vo.ZmanVO;
import com.itwillbs.zero.vo.ZpayVO;

@Mapper
public interface ZmanDeliveryMapper {

	// ZMAN 의 프로필 정보 가져오기
	ZmanVO selectZmanProfile(String zmanId);
	
	// 배달 예정 목록 조회
	List<ZmanDeliveryVO> selectDeliveryYetList();
	
	// ZMAN 배달 출발지 리스트 가져오기
	List<ZmanDeliveryVO> selectDeliveryStartspotList(Long markerId);

	// DB 에 저장된 출발지와 도착지 가져오기 - 파라미터 zman_delivery_idx
	ZmanDeliveryVO selectDeliveryLocation();

	// ZMAN 중고물품 오더 배달 수락하기
	int updateDelivery(@Param("zman_delivery_idx") int zman_delivery_idx, @Param("zman_id") String zman_id);

	// 배달 상세 정보 - 출발지와 배달지 가져오기
	ZmanDeliveryVO selectDeliveryDetail(int zman_delivery_idx);


	// ZMAN zman_delivery_status "배달 시작" 로 변경하기
	int updateDeliveryDetail(int zman_delivery_idx);

	// ZMAN zman_delivery_status "배달 완료" 로 변경하기
	int updateDeliveryEnd(int zman_delivery_idx);

	// "배달 완료" 후 정산 테이블에 삽입하기
	int insertDeliveryDone(@Param("zman_delivery_idx") int zman_delivery_idx, @Param("zman_id") String zman_id, @Param("zman_delivery_commission") int zman_delivery_commission);


	// 배달 완료 상세 페이지 - 정산 완료인지 확인하기
	ZmanRefundHistoryVO selectEaningRefundIdx(int zmanDeliveryIdx);
	
	// 배달 완료 상세 페이지에서 정산으로 넘겨줄 파라미터
	ZmanEarningVO selectZmanEarningIdx(int zmanDeliveryIdx);
	
	// ZMAN 정산리스트 가져오기
	List<ZmanDeliveryVO> selectZmanEarningList(String zman_id);
	
	// 마커 클릭 시 보여줄 정보 가져오기
	List<ZmanDeliveryVO> selectMarkerClickInfo(String markerTitle);


	// ZMAN 배달 완료 내역 페이지로 이동
//	List<ZmanDeliveryVO> selectDeliveryDoneList();
//	List<ZmanDeliveryVO> selectDeliveryDoneList(String member_id);
	List<ZmanDeliveryVO> selectDeliveryDoneList(String zman_id);

	// ZMAN 마이페이지의 ZPAY 정보 가져오기
	ZpayVO selectZpay(String member_id);





	// ZMAN 중고물품 배달 시작하기
//	int updateDeliveryDetailStart(int zman_delivery_idx);


}
