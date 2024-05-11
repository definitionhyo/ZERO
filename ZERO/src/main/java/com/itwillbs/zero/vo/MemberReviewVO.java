package com.itwillbs.zero.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberReviewVO {
	private int member_review_idx;
	private int member_review_rating;
	private String member_review_content;
	private Date member_review_date;  // java.sql 임포트
	private String review_writer_id;
	private String review_reader_id;
	private int order_secondhand_idx;
}
