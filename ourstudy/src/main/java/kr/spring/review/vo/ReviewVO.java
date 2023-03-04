package kr.spring.review.vo;

import java.io.IOException;
import java.sql.Date;
import java.util.Arrays;

import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

public class ReviewVO {	
	private int r_num;
	@NotEmpty
	private String r_title;
	@NotEmpty
	private String r_content;
	private Date r_date;
	private Date r_mdate;
	private int r_rate;
	private byte[] r_img;
	private String r_imgname;
	private int mem_num;
	private String mem_name;

	//====이미지 BLOB 처리====//
	//(주의)폼에서 파일업로드 파라미터네임은 반드시 upload로 지정해야 함(img로 하면 안 됨! upload로 받은 걸 photo로 바꿀 거라서)
	public void setUpload(MultipartFile upload) throws IOException{

		//MultipartFile -> byte[]
		setR_img(upload.getBytes());
		//파일 이름
		setR_imgname(upload.getOriginalFilename());
	}
	
	public int getR_num() {
		return r_num;
	}
	public void setR_num(int r_num) {
		this.r_num = r_num;
	}
	public String getR_title() {
		return r_title;
	}
	public void setR_title(String r_title) {
		this.r_title = r_title;
	}
	public String getR_content() {
		return r_content;
	}
	public void setR_content(String r_content) {
		this.r_content = r_content;
	}
	public Date getR_date() {
		return r_date;
	}
	public void setR_date(Date r_date) {
		this.r_date = r_date;
	}
	public Date getR_mdate() {
		return r_mdate;
	}
	public void setR_mdate(Date r_mdate) {
		this.r_mdate = r_mdate;
	}
	public int getR_rate() {
		return r_rate;
	}
	public void setR_rate(int r_rate) {
		this.r_rate = r_rate;
	}
	public byte[] getR_img() {
		return r_img;
	}
	public void setR_img(byte[] r_img) {
		this.r_img = r_img;
	}
	public String getR_imgname() {
		return r_imgname;
	}
	public void setR_imgname(String r_imgname) {
		this.r_imgname = r_imgname;
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
		return "ReviewVO [r_num=" + r_num + ", r_title=" + r_title + ", r_content=" + r_content + ", r_date=" + r_date
				+ ", r_mdate=" + r_mdate + ", r_rate=" + r_rate + ", r_img=" + Arrays.toString(r_img) + ", r_imgname="
				+ r_imgname + ", mem_num=" + mem_num + ", mem_name=" + mem_name + "]";
	}
}
