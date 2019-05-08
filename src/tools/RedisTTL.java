package tools;

import redis.clients.jedis.Jedis;

public class RedisTTL {
	
	public String confirmTTL(String mem_mail) {
		Jedis jedis = new Jedis("localhost",6379);
		jedis.auth("123456");
		String code = returnAuthCode();
		jedis.set(mem_mail, code);
		jedis.expire(mem_mail, 120);
		
		return code;
	}
	
	public String authJudge(String mem_mail,String authJudge) {
		Jedis jedis = new Jedis("localhost",6379);
		jedis.auth("123456");
		String judgeConsole;
		String answer = jedis.get(mem_mail);
		System.out.println("authjudge--------------------");
		System.out.println(jedis.get(mem_mail));
		if(answer==null) {
			judgeConsole = "overTime";
		}else if(answer.equals(authJudge)) {
			judgeConsole = "Yes";
		}else {
			judgeConsole = "No";
		}
		
		
		
		return judgeConsole;
		
	}
	
	private static String returnAuthCode() {
		StringBuilder sb = new StringBuilder();
		for (int i = 1; i <= 8; i++) {
			int condition = (int) (Math.random() * 3) + 1;
			switch (condition) {
			case 1:
				char c1 = (char)((int)(Math.random() * 26) + 65);
				sb.append(c1);
				break;
			case 2:
				char c2 = (char)((int)(Math.random() * 26) + 97);
				sb.append(c2);
				break;
			case 3:
				sb.append((int)(Math.random() * 10));
			}
		}
		return sb.toString();
	}
}
