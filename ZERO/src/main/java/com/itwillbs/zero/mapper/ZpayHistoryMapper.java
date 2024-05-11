//package com.itwillbs.zero.mapper;
//
//import java.util.List;
//
//import org.apache.ibatis.annotations.Mapper;
//
//import com.itwillbs.zero.vo.ZpayHistoryVO;
//
//@Mapper
//public interface ZpayHistoryMapper {
//	
//		// ZPAY 잔액 조회
//		Integer selectZpayBalance(String member_id);
//
//		// ZPAY 사용 내역(목록) 조회
//		List<ZpayHistoryVO> selectZpayHistory(String member_id);
//
//		// ZPAY 번호 조회
//		int selectZpayIdx(String member_id);
//
//		// ZPYA_HISTORY 테이블에 충전내역 추가
//		int insertZpayHistory(ZpayHistoryVO zpayHistory);
//		
//}
