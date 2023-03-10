package kr.spring.info.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;


public class InformationVO {
	private int info_num;
	private Date info_date; 
	@NotEmpty
	@Size(max=30)
	private String info_title;
	@NotEmpty
	private String info_content;
	private int info_pin;
	private int mem_num;
	private Date info_modify_date;
	private byte[] uploadfile;
	private String filename;
	
	//파일 업로드 처리
	public void setUpload(MultipartFile upload)
		                          throws IOException{
		//MultipartFile -> byte[] 변환
		setUploadfile(upload.getBytes());
		//파일명 구하기
		setFilename(upload.getOriginalFilename());
		}
	
	public int getInfo_num() {
		return info_num;
	}
	public void setInfo_num(int info_num) {
		this.info_num = info_num;
	}
	public Date getInfo_date() {
		return info_date;
	}
	public void setInfo_date(Date info_date) {
		this.info_date = info_date;
	}
	public String getInfo_title() {
		return info_title;
	}
	public void setInfo_title(String info_title) {
		this.info_title = info_title;
	}
	public String getInfo_content() {
		return info_content;
	}
	public void setInfo_content(String info_content) {
		this.info_content = info_content;
	}
	public int getInfo_pin() {
		return info_pin;
	}
	public void setInfo_pin(int info_pin) {
		this.info_pin = info_pin;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	
	public Date getInfo_modify_date() {
		return info_modify_date;
	}
	public void setInfo_modify_date(Date info_modify_date) {
		this.info_modify_date = info_modify_date;
	}
	public byte[] getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(byte[] uploadfile) {
		this.uploadfile = uploadfile;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	
	
	@Override
	public String toString() {
		return "InformationVO [info_num=" + info_num +", info_date=" + info_date + ", info_title=" + info_title +
				", info_content=" + info_content + ", info_pin=" + info_pin + ", mem_num=" + mem_num + 
				", info_modify_date=" + info_modify_date + ", filename=" + filename +"]";
	}
	
}