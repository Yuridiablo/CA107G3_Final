package com.ord.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.json.JSONObject;

import javax.websocket.Session;
import javax.websocket.OnOpen;
import javax.websocket.OnMessage;
import javax.websocket.OnError;
import javax.websocket.OnClose;
import javax.websocket.CloseReason;

@ServerEndpoint("/EchoServer/{booking_date}/{party_size}")
public class EchoServer {

	private static final Set<Session> allSessions_2 = Collections.synchronizedSet(new HashSet<Session>());
	private static final Set<Session> allSessions_4 = Collections.synchronizedSet(new HashSet<Session>());
	private static final Set<Session> allSessions_6 = Collections.synchronizedSet(new HashSet<Session>());
	private static final Set<Session> allSessions_8 = Collections.synchronizedSet(new HashSet<Session>());
	private static final Set<Session> allSessions_10 = Collections.synchronizedSet(new HashSet<Session>());

	@OnOpen
	public void onOpen(@PathParam("booking_date") String booking_date, @PathParam("party_size") int party_size,
			Session userSession) throws IOException {
System.out.println("開始連線");
		if (party_size == 1 || party_size == 2) {
			allSessions_2.add(userSession);
		} else if (party_size == 3 || party_size == 4) {
			allSessions_4.add(userSession);
		} else if (party_size == 5 || party_size == 6) {
			allSessions_6.add(userSession);
		} else if (party_size == 7 || party_size == 8) {
			allSessions_8.add(userSession);
		} else if (party_size == 9 || party_size == 10) {
			allSessions_10.add(userSession);
		}

		System.out.println(userSession.getId() + ": 已連線");
		System.out.println(booking_date + ": 已連線");
		System.out.println(party_size + ": 房號");

//		userSession.getBasicRemote().sendText("WebSocket 連線成功");
	}

	@OnMessage
	public void onMessage(Session userSession, String message) {
		
//		for (Session session : allSessions) {
//			if (session.isOpen() && !userSession.getId().equals(session.getId()))
//				session.getAsyncRemote().sendText(message);
//		}
		JSONObject jobject=new JSONObject(message);
	System.out.println(jobject);
		
		String rto_no=	(String) jobject.get("rto_no");
		System.out.println(rto_no);
		Integer party_size=(Integer) jobject.get("party_size");
		
		if (party_size == 1 || party_size == 2) {
			for (Session session : allSessions_2) {
			if (session.isOpen() && !userSession.getId().equals(session.getId()))
					session.getAsyncRemote().sendText(rto_no);
		}
		} else if (party_size == 3 || party_size == 4) {
			for (Session session : allSessions_4) {
				if (session.isOpen() && !userSession.getId().equals(session.getId()))
						session.getAsyncRemote().sendText(rto_no);
			}
		} else if (party_size == 5 || party_size == 6) {
			for (Session session : allSessions_6) {
				if (session.isOpen() && !userSession.getId().equals(session.getId()))
						session.getAsyncRemote().sendText(rto_no);
			}
		} else if (party_size == 7 || party_size == 8) {
			for (Session session : allSessions_8) {
				if (session.isOpen() && !userSession.getId().equals(session.getId()))
						session.getAsyncRemote().sendText(rto_no);
			}
		} else if (party_size == 9 || party_size == 10) {
			for (Session session : allSessions_10) {
				if (session.isOpen() && !userSession.getId().equals(session.getId()))
						session.getAsyncRemote().sendText(rto_no);
			}
		}
		System.out.println("Message received: " + message);

	}

	@OnError
	public void onError(Session userSession, Throwable e) {
//			e.printStackTrace();
	}

	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
//		allSessions.remove(userSession);

		String text = String.format("session ID = %s, disconnected; close code = %d; reason phrase = %s",
				userSession.getId(), reason.getCloseCode().getCode(), reason.getReasonPhrase());
		System.out.println(text);

	}
}
