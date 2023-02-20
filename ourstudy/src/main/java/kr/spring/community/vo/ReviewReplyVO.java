package kr.spring.community.vo;

import java.sql.Date;

public class ReviewReplyVO {
	private int revw_num;
	private Date revw_date;
	private String revw_content;
	private int r_num;
	private int mem_num;
	
	public int getRevw_num() {
		return revw_num;
	}
	public void setRevw_num(int revw_num) {
		this.revw_num = revw_num;
	}
	public Date getRevw_date() {
		return revw_date;
	}
	public void setRevw_date(Date revw_date) {
		this.revw_date = revw_date;
	}
	public String getRevw_content() {
		return revw_content;
	}
	public void setRevw_content(String revw_content) {
		this.revw_content = revw_content;
	}
	public int getR_num() {
		return r_num;
	}
	public void setR_num(int r_num) {
		this.r_num = r_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	
	
}
