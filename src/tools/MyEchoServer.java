package tools;
import java.io.*;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.json.JSONException;
import org.json.JSONObject;

import javax.websocket.Session;
import javax.websocket.OnOpen;
import javax.websocket.OnMessage;
import javax.websocket.OnError;
import javax.websocket.OnClose;
import javax.websocket.CloseReason;

@ServerEndpoint("/MyEchoServer/{myName}/{myRoom}")
public class MyEchoServer {
	
//private static final Set<Session> allSessions = Collections.synchronizedSet(new HashSet<Session>());
private static ConcurrentHashMap<String, Session> webSocketMap = new ConcurrentHashMap<String, Session>();
	
	@OnOpen
	public void onOpen(@PathParam("myName") String myName, @PathParam("myRoom") String myRoom, Session userSession) throws IOException {
//		allSessions.add(userSession);
		webSocketMap.put(myRoom, userSession);
		System.out.println(userSession.getId() + ": 已連線");
		System.out.println(myName + ": 已連線");
		System.out.println(myRoom + ": 房號");
	}

	
	@OnMessage
	public void onMessage(Session userSession, String jsonMsg) throws JSONException {
		JSONObject jsonObject = new JSONObject(jsonMsg);
		String toUser = jsonObject.getString("toUser");
		System.out.println("toUser="+toUser);
		if(toUser.equals("employee")) {
			webSocketMap.get("employee").getAsyncRemote().sendText(jsonMsg);
		}else {
			webSocketMap.get(toUser).getAsyncRemote().sendText(jsonMsg);
		}
		userSession.getAsyncRemote().sendText(jsonMsg);
		
		System.out.println(jsonMsg+"111111111111222222222222233333333333333");
		System.out.println(toUser+"555555");
//		for (Session session : allSessions) {
//			if (session.isOpen())
//				session.getAsyncRemote().sendText(message);
//		}
		System.out.println("Message received: " + jsonMsg);
	}
	
	@OnError
	public void onError(Session userSession, Throwable e){
		e.printStackTrace();
	}
	
	@OnClose
	public void onClose(Session userSession, CloseReason reason,@PathParam("myRoom") String myRoom) {
//		allSessions.remove(userSession);
		webSocketMap.remove(myRoom);
		System.out.println(userSession.getId() + ": Disconnected: " + Integer.toString(reason.getCloseCode().getCode()));
	}

 
}
