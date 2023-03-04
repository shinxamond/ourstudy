package kr.spring.review.vo;

import java.io.IOException;
import java.sql.Date;

import kr.spring.util.DurationFromNow;

public class ReviewReplyVO {		
	private int revw_num;
	private String revw_date;
	private String revw_mdate;
	private String revw_content;
	private int r_num;
	private int mem_num;
	private String mem_name;

	public int getRevw_num() {
		return revw_num;
	}
	public void setRevw_num(int revw_num) {
		this.revw_num = revw_num;
	}
	public String getRevw_date() {
		return revw_date;
	}
	public void setRevw_date(Date revw_date) {
		this.revw_date = DurationFromNow.getTimeDiffLabel(revw_date);
	}
	public String getRevw_mdate() {
		return revw_mdate;
	}
	public void setRevw_mdate(Date revw_mdate) {
		this.revw_mdate = DurationFromNow.getTimeDiffLabel(revw_mdate);
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
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	
	@Override
	public String toString() {
		return "ReviewReplyVO [revw_num=" + revw_num + ", revw_date=" + revw_date + ", revw_mdate=" + revw_mdate
				+ ", revw_content=" + revw_content + ", r_num=" + r_num + ", mem_num=" + mem_num + ", mem_name="
				+ mem_name + "]";
	}
}
