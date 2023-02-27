package kr.spring.community.vo;

import java.sql.Date;

public class LostReplyVO {
	private int re_num;
	private Date re_date;
	private String re_content;
	private int lf_num;
	private int mem_num;
	
	public int getRe_num() {
		return re_num;
	}
	public void setRe_num(int re_num) {
		this.re_num = re_num;
	}
	public Date getRe_date() {
		return re_date;
	}
	public void setRe_date(Date re_date) {
		this.re_date = re_date;
	}
	public String getRe_content() {
		return re_content;
	}
	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}
	public int getLf_num() {
		return lf_num;
	}
	public void setLf_num(int lf_num) {
		this.lf_num = lf_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	
	
	@Override
	public String toString() {
		return "LostReplyVO [re_num=" + re_num +", re_date" + re_date + ", re_content" + re_content +
				", lf_num" + lf_num + ", mem_num" + mem_num + "]";
	}
	
}
