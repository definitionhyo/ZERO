package com.itwillbs.zero.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.zero.vo.AuctionProductVO;

@Mapper
public interface AuctionMapper2 {

	List<HashMap<String, String>> selectCategoryList();

	List<HashMap<String, String>> selectBrandList();

	int insertProduct(AuctionProductVO auctionProduct);

	void insertAuctionManaging(AuctionProductVO auctionProduct);


	HashMap<String, String> selectAuctionProduct(int id);

	List<HashMap<String, String>> selectAuctionLog(int id);

	int insertLog(Map<String, String> map);

	int selectMaxPrice(Map<String, String> map);

	List<HashMap<String, String>> selectWinnerList(String now);

	int updateWinner(HashMap<String, String> winner);

	int updateEnd(String now);

	int selectBidedZpay(@Param("member_id")String member_id, @Param("id")int id);

	void insertOrder(HashMap<String, String> product);

	int selectoOderauctionIdx(int id);

	void insertOrder2(HashMap<String, String> winner);

	int selectAllBidedZpay(String member_id);

	int selectAuctionIdx();

	HashMap<String, String> selectSellerInfo(String member_id);

	

}
