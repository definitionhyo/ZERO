package com.itwillbs.zero.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.itwillbs.zero.mapper.AuctionMapper2;
import com.itwillbs.zero.vo.AuctionProductVO;

@Service
public class AuctionService2  {
	@Autowired
	private AuctionMapper2 mapper;
	public List<HashMap<String, String>> getCategory() {
		return mapper.selectCategoryList();
		}
	public List<HashMap<String, String>> getBrand() {
		// TODO Auto-generated method stub
		return  mapper.selectBrandList();
	}
	public int registProduct(AuctionProductVO auctionProduct) {
		int insertcount= mapper.insertProduct(auctionProduct);
		mapper.insertAuctionManaging(auctionProduct);
		
		return  insertcount;
	}
	public HashMap<String, String> getAuctionProduct(int id) {
		// TODO Auto-generated method stub
		return mapper.selectAuctionProduct(id);
	}
	public List<HashMap<String, String>> getAuctionLog(int id) {
		// TODO Auto-generated method stub
		return mapper.selectAuctionLog(id);
	}
	public int registLog(Map<String, String> map) {
		// TODO Auto-generated method stub
		return mapper.insertLog(map);
	}
	public int getMaxPrice(Map<String, String> map) {
		// TODO Auto-generated method stub
		return mapper.selectMaxPrice(map);
	}
	public List<HashMap<String, String>> getWinner(String now) {
		// TODO Auto-generated method stub
		return mapper.selectWinnerList(now);
	}
	public int registWinner(HashMap<String, String> winner) {
		// TODO Auto-generated method stub
		return mapper.updateWinner(winner);
	}
	public int registEnd(String now) {
		// TODO Auto-generated method stub
		return mapper.updateEnd(now);
	}
	public int getBidedZpay(String member_id, int id) {
		// TODO Auto-generated method stub
		return mapper.selectBidedZpay(member_id, id);
	}
	public void registOrder(HashMap<String, String> product) {
		mapper.insertOrder(product);
	}
	public int getOderauctionIdx(int id) {
		return mapper.selectoOderauctionIdx(id);
		
	}
	public void registOrder2(HashMap<String, String> winner) {
		mapper.insertOrder2(winner);
		
	}
	public int getAllBidedZpay(String member_id) {
		// TODO Auto-generated method stub
		return mapper.selectAllBidedZpay(member_id);
	}
	public int getAuctionIdx() {
		// TODO Auto-generated method stub
		return mapper.selectAuctionIdx();
	}
	public HashMap<String, String> getSellerInfo(String member_id) {
		// TODO Auto-generated method stub
		return mapper.selectSellerInfo(member_id);
	}

}
