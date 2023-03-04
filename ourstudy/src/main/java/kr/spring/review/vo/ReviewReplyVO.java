package kr.spring.review.vo;

import java.io.IOException;
import java.sql.Date;

public class ReviewReplyVO {		
	private int revw_num;
	private Date revw_date;
	private Date revw_mdate;
	private String revw_content;	

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
	public Date getRevw_mdate() {
		return revw_mdate;
	}
	public void setRevw_mdate(Date revw_mdate) {
		this.revw_mdate = revw_mdate;
	}
	public String getRevw_content() {
		return revw_content;
	}
	public void setRevw_content(String revw_content) {
		this.revw_content = revw_content;
	}
	
	@Override
	public String toString() {
		return "ReviewReplyVO [revw_num=" + revw_num + ", revw_date=" + revw_date + ", revw_mdate=" + revw_mdate
				+ ", revw_content=" + revw_content + "]";
	}
}
