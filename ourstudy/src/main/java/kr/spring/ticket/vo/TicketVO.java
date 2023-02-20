package kr.spring.ticket.vo;

public class TicketVO {
	private int ticket_num;
	private int ticket_kind;
	private String ticket_name;
	private int ticket_type;
	private int ticket_price;

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

	@Override
	public String toString() {
		return "TicketVO [ticket_num=" + ticket_num + ", ticket_kind=" + ticket_kind + ", ticket_name=" + ticket_name
				+ ", ticket_type=" + ticket_type + ", ticket_price=" + ticket_price + "]";
	}
	
	
}
