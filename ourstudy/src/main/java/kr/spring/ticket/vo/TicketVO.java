package kr.spring.ticket.vo;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Range;

public class TicketVO {
	private int ticket_num;
	@Range(min=1,max=2)
	private int ticket_kind;
	@NotEmpty
	private String ticket_name;
	@Range(min=1,max=9)
	private int ticket_type;
	@Range(min=1000)
	private int ticket_price;
	
	private int locker_num;

	public int getTicket_num() {
		return ticket_num;
	}

	public void setTicket_num(int ticket_num) {
		this.ticket_num = ticket_num;
	}

	public int getTicket_kind() {
		return ticket_kind;
	}

	public void setTicket_kind(int ticket_kind) {
		this.ticket_kind = ticket_kind;
	}

	public String getTicket_name() {
		return ticket_name;
	}

	public void setTicket_name(String ticket_name) {
		this.ticket_name = ticket_name;
	}

	public int getTicket_type() {
		return ticket_type;
	}

	public void setTicket_type(int ticket_type) {
		this.ticket_type = ticket_type;
	}

	public int getTicket_price() {
		return ticket_price;
	}

	public void setTicket_price(int ticket_price) {
		this.ticket_price = ticket_price;
	}
	
	public int getLocker_num() {
		return locker_num;
	}

	public void setLocker_num(int locker_num) {
		this.locker_num = locker_num;
	}

	@Override
	public String toString() {
		return "TicketVO [ticket_num=" + ticket_num + ", ticket_kind=" + ticket_kind + ", ticket_name=" + ticket_name
				+ ", ticket_type=" + ticket_type + ", ticket_price=" + ticket_price + "]";
	}
}
