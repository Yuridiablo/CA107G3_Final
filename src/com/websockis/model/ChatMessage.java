package com.websockis.model;

public class ChatMessage {
	private String type;
	private String sender;
	private String receiver;
	private String message;
	private String name;

	public ChatMessage(String type, String sender, String receiver, String message ,String name) {
		this.type = type;
		this.sender = sender;
		this.receiver = receiver;
		this.message = message;
		this.name = name;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
