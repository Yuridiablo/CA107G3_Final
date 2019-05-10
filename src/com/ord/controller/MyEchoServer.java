package com.ord.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import javax.websocket.Session;
import javax.websocket.OnOpen;
import javax.websocket.OnMessage;
import javax.websocket.OnError;
import javax.websocket.OnClose;
import javax.websocket.CloseReason;

@ServerEndpoint("/MyEchoServer/{booking_date}/{party_size}")
	public class MyEchoServer {
		
	private static final Set<Session> allSessions = Collections.synchronizedSet(new HashSet<Session>());
	
		
		@OnOpen
		public void onOpen(@PathParam("booking_date") String booking_date, @PathParam("party_size") int party_size, Session userSession) throws IOException {
		
			
			allSessions.add(userSession);
			System.out.println(userSession.getId() + ": 已連線");
			System.out.println(booking_date + ": 已連線");
			System.out.println(party_size + ": 房號");
		
			userSession.getBasicRemote().sendText("WebSocket 連線成功");
		}

		
		@OnMessage
		public void onMessage(Session userSession, String message) {
			for (Session session : allSessions) {
				if (session.isOpen() && !userSession.getId().equals(session.getId()))
					session.getAsyncRemote().sendText(message);
			}
			System.out.println("Message received: " + message);
			
		}
		
		@OnError
		public void onError(Session userSession, Throwable e){
//			e.printStackTrace();
		}
		
		@OnClose
		public void onClose(Session userSession, CloseReason reason) {
			allSessions.remove(userSession);
			
			String text = String.format("session ID = %s, disconnected; close code = %d; reason phrase = %s",
					userSession.getId(), reason.getCloseCode().getCode(), reason.getReasonPhrase());
			System.out.println(text);
			
			
		}
}
