package com.itwillbs.zero.vo;

import lombok.Data;

@Data
public class ReportVO {
	private int report_idx;
	private String report_type;
	private int secondhand_idx;
	private String report_content;
	private String report_status;
	private String report_datetime;
	private String report_member_id;
	private String reported_member_id;
}
