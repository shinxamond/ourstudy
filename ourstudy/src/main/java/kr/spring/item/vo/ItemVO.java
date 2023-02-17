package kr.spring.item.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.NotEmpty;

import org.hibernate.validator.constraints.Range;
import org.springframework.web.multipart.MultipartFile;

public class ItemVO {
	private int item_num;
	@Range(min=1,max=99)
	private int item_index;
	@NotEmpty
	private String item_title;
	private byte[] item_ufile;
	private String item_imgsrc;
	private Date item_start;
	private Date item_end;
	private Date item_utime;
	private int item_p_status;
	private int item_r_status;
	private int mem_num;
	@Range(min=1,max=30)
	private int item_time;
	
	public void setUpload(MultipartFile upload)throws IOException{
		//multipartFile -> byte[]변환
		setItem_ufile(upload.getBytes());
		//파일명 구하기
		setItem_imgsrc(upload.getOriginalFilename());
	}
	
	
	public byte[] getItem_ufile() {
		return item_ufile;
	}
	public void setItem_ufile(byte[] item_ufile) {
		this.item_ufile = item_ufile;
	}
	
	public Date getItem_utime() {
		return item_utime;
	}
	public void setItem_utime(Date item_utime) {
		this.item_utime = item_utime;
	}
	public int getItem_num() {
		return item_num;
	}
	public void setItem_num(int item_num) {
		this.item_num = item_num;
	}
	public int getItem_index() {
		return item_index;
	}
	public void setItem_index(int item_index) {
		this.item_index = item_index;
	}
	public String getItem_title() {
		return item_title;
	}
	public void setItem_title(String item_title) {
		this.item_title = item_title;
	}
	public String getItem_imgsrc() {
		return item_imgsrc;
	}
	public void setItem_imgsrc(String item_imgsrc) {
		this.item_imgsrc = item_imgsrc;
	}
	public Date getItem_start() {
		return item_start;
	}
	public void setItem_start(Date item_start) {
		this.item_start = item_start;
	}
	public Date getItem_end() {
		return item_end;
	}
	public void setItem_end(Date item_end) {
		this.item_end = item_end;
	}
	public int getItem_p_status() {
		return item_p_status;
	}
	public void setItem_p_status(int item_p_status) {
		this.item_p_status = item_p_status;
	}
	public int getItem_r_status() {
		return item_r_status;
	}
	public void setItem_r_status(int item_r_status) {
		this.item_r_status = item_r_status;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getItem_time() {
		return item_time;
	}
	public void setItem_time(int item_time) {
		this.item_time = item_time;
	}


	@Override
	public String toString() {
		return "ItemVO [item_num=" + item_num + ", item_index=" + item_index + ", item_title=" + item_title
				+ ", item_imgsrc=" + item_imgsrc + ", item_start=" + item_start + ", item_end=" + item_end
				+ ", item_utime=" + item_utime + ", item_p_status=" + item_p_status + ", item_r_status=" + item_r_status
				+ ", mem_num=" + mem_num + ", item_time=" + item_time + "]";
	}
	
	
	
	
}
