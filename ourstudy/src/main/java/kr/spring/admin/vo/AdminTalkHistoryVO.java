package kr.spring.admin.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

public class AdminTalkHistoryVO {
	private int talk_num;
	private int mem_num;
	private String mem_name;
	private Date chat_date; //나중에 String으로 변환해야할수도
	private String message;
	
	public int getTalk_num() { 
		return talk_num;
	}
	public void setTalk_num(int talk_num) {
		this.talk_num = talk_num;
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
	public Date getChat_date() {
		return chat_date;
	}
	public void setChat_date(Date chat_date) {
		this.chat_date = chat_date;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
	@Override
	public String toString() {
		return "AdminTalkHistoryVO [talk_num=" + talk_num + ", mem_num=" + mem_num + ", mem_name=" + mem_name
				+ ", chat_date=" + chat_date + ", message=" + message + "]";
	}
	
}
