package kr.spring.community.vo;

import java.sql.Date;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

public class LostVO {
	private int lf_num;
	private int lf_type;
	@NotEmpty
	@Size(max=30)
	private String lf_title;
	@NotEmpty
	private String lf_content;
	private int f_condition;
	private int mem_num;
	private Date lf_date;
	@NotEmpty
	private String lf_time;
	@NotEmpty
	@Size(max=30)
    private String lf_item;
	@NotEmpty
	@Size(max=30)
	private String lf_loc;
	private Date lf_modify_date;
	private String mem_name;
	
	public int getLf_num() {
		return lf_num;
	}
	public void setLf_num(int lf_num) {
		this.lf_num = lf_num;
	}
	public int getLf_type() {
		return lf_type;
	}
	public void setLf_type(int lf_type) {
		this.lf_type = lf_type;
	}
	public String getLf_title() {
		return lf_title;
	}
	public void setLf_title(String lf_title) {
		this.lf_title = lf_title;
	}
	public String getLf_content() {
		return lf_content;
	}
	public void setLf_content(String lf_content) {
		this.lf_content = lf_content;
	}
	public int getF_condition() {
		return f_condition;
	}
	public void setF_condition(int f_condition) {
		this.f_condition = f_condition;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public Date getLf_date() {
		return lf_date;
	}
	public void setLf_date(Date lf_date) {
		this.lf_date = lf_date;
	}
	public String getLf_item() {
		return lf_item;
	}
	public void setLf_item(String lf_item) {
		this.lf_item = lf_item;
	}
	public String getLf_loc() {
		return lf_loc;
	}
	public void setLf_loc(String lf_loc) {
		this.lf_loc = lf_loc;
	}
	public Date getLf_modify_date() {
		return lf_modify_date;
	}
	public void setLf_modify_date(Date lf_modify_date) {
		this.lf_modify_date = lf_modify_date;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
    public String getLf_time() {
			return lf_time;
	}
	public void setLf_time(String lf_time) {
			this.lf_time = lf_time;
	}



	
	
	@Override
	public String toString() {
		return "LostVO [lf_num=" + lf_num +", lf_type=" + lf_type + ", lf_title=" + lf_title +
				", lf_content=" + lf_content + ", f_condition=" + f_condition + 
				", lf_date=" + lf_date + ", lf_item=" + lf_item + ", lf_time=" + lf_time + 
				", lf_loc=" + lf_loc + ", lf_modify_date=" + lf_modify_date + 
				", mem_name=" + mem_name + ", mem_num=" + mem_num + "]";
	}
	
	
}
