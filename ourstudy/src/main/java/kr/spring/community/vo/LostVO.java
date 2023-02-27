package kr.spring.community.vo;

public class LostVO {
	private int lf_num;
	private int lf_type;
	private String lf_title;
	private String lf_content;
	private String lf_imgsrc;
	private int f_condition;
	private int mem_num;
	
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
	public String getLf_imgsrc() {
		return lf_imgsrc;
	}
	public void setLf_imgsrc(String lf_imgsrc) {
		this.lf_imgsrc = lf_imgsrc;
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
	
	
	@Override
	public String toString() {
		return "LostVO [lf_num=" + lf_num +", lf_type" + lf_type + ", lf_title" + lf_title +
				", lf_content" + lf_content + ", lf_imgsrc" + lf_imgsrc + ", f_condition" + f_condition + ", mem_num" + mem_num + "]";
	}
	
	
}
