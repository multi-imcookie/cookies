package com.multi.cookies.chat;

//브라우저(클라이언트)가 입력해서 서버로 전송한 내용을 받는 역할 
public class Message extends Object {

	private String from;
	private String text;

	public Message(String from, String text) {
		super(); //부모클래스인 Object()를 먼저 호출하여 먼저 객체를 만들어라.!
		//super()는 무조건 맨 윗줄!!, 자동호출(생략 가능)
		this.from = from;
		this.text = text;
	}

	public Message() {
		//super();
		// TODO Auto-generated constructor stub
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	@Override
	public String toString() {
		return "Message [from=" + from + ", text=" + text + "]";
	}
}
