package com.itwillbs.zero.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.zero.mapper.ZmanDeliveryMapper;
import com.itwillbs.zero.vo.ZmanDeliveryVO;
import com.itwillbs.zero.vo.ZmanEarningVO;
import com.itwillbs.zero.vo.ZmanRefundHistoryVO;
import com.itwillbs.zero.vo.ZmanVO;
import com.itwillbs.zero.vo.ZpayVO;

@Service
public class ZmanDeliveryService {
	
	@Autowired
	private ZmanDeliveryMapper mapper;
	
	// ZMAN 의 프로필 정보 가져오기
	public ZmanVO getZmanProfile(String zmanId) {
		return mapper.selectZmanProfile(zmanId);
	}

	// 배달 예정 목록 조회
	public List<ZmanDeliveryVO> getDeliveryYetList() {
		return mapper.selectDeliveryYetList();
	}
	
	// ZMAN 배달 출발지 리스트 가져오기
	public List<ZmanDeliveryVO> getDelivertStartspotList(Long markerId) {
		return mapper.selectDeliveryStartspotList(markerId);
	}

	// ZMAN zman_delivery_status "배달 수락"로 변경하기
	public int acceptDelivery(int zman_delivery_idx, String zman_id) {
		return mapper.updateDelivery(zman_delivery_idx, zman_id);
	}


	// 배달 상세 정보 - 출발지와 배달지 가져오기
	public ZmanDeliveryVO getDeliveryDetail(int zman_delivery_idx) {
		return mapper.selectDeliveryDetail(zman_delivery_idx);
	}
	


	// ZMAN zman_delivery_status "배달 시작" 로 변경하기
	public int updateDeliveryStatus(int zman_delivery_idx) {
		return mapper.updateDeliveryDetail(zman_delivery_idx);
	}

	// ZMAN zman_delivery_status "배달 완료" 로 변경하기
	public int updateDeliveryStatusEnd(int zman_delivery_idx) {
		return mapper.updateDeliveryEnd(zman_delivery_idx);
	}
	
	// "배달 완료" 후 정산 테이블에 삽입하기
	public int insertDeliveryEarning(int zman_delivery_idx, String zman_id, int zman_delivery_commission) {
		return mapper.insertDeliveryDone(zman_delivery_idx, zman_id, zman_delivery_commission);
	}

	// 마커 클릭 시 보여줄 정보 가져오기
	public List<ZmanDeliveryVO> getMarkerClickInfo(String markerTitle) {
		return mapper.selectMarkerClickInfo(markerTitle);
	}


	// ZMAN 배달 완료 리스트 가져오기
//	public List<ZmanDeliveryVO> getDeliveryDoneList() {
//		return mapper.selectDeliveryDoneList();
//	}
	public List<ZmanDeliveryVO> getDeliveryDoneList(String zman_id) {
		// TODO Auto-generated method stub
		return mapper.selectDeliveryDoneList(zman_id);
	}
	
	// 배달 완료 상세 페이지 - 정산 완료인지 확인하기
	public ZmanRefundHistoryVO getEarningRefundIdx(int zmanDeliveryIdx) {
		return mapper.selectEaningRefundIdx(zmanDeliveryIdx);
	}
	
	// 배달 내역 상세 페이지에서 정산으로 넘겨줄 파라미터
	public ZmanEarningVO getEarningIdx(int zmanDeliveryIdx) {
		return mapper.selectZmanEarningIdx(zmanDeliveryIdx);
	}

	// ZMAN 정산리스트 가져오기
	public List<ZmanDeliveryVO> getEarningList(String zman_id) {
		return mapper.selectZmanEarningList(zman_id);
	}

	// ZMAN 마이페이지의 ZPAY 정보 가져오기
	public ZpayVO getZpay(String member_id) {
		return mapper.selectZpay(member_id);
	}







	




}
