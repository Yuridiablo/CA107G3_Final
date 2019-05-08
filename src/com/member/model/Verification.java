package com.member.model;



import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Verification extends HttpServlet {
	public void doGet(HttpServletRequest req,HttpServletResponse res) throws IOException {
		res.setHeader("Cache-Control", "no-store");
		res.setHeader("Pragma", "no-cache");
		res.setHeader("Expires", "0");
		res.setContentType("image/jpeg");
		
		int width=150,height=100;
		BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		
		Graphics graphic = image.getGraphics();
		
		graphic.setColor(getRandColor(200, 255));
		graphic.fillRect(0, 0, width, height);
		graphic.setFont(new Font("�з���",Font.PLAIN,65));
		
		Random random=new Random();
		graphic.setColor(getRandColor(160, 200));
		
		for(int i=0;i<155;i++) {
			int x = random.nextInt(width);
			int y = random.nextInt(height);
			int x1 = random.nextInt(12);
			int y1 = random.nextInt(12);
			
			graphic.drawLine(x, y, x+x1, y+y1);
		}
		
		String randString1 = req.getParameter("vstring");
		String randString3 = req.getParameter("vstring3");
		System.out.println(randString1);
//		String randString2 = randString1.substring(0,randString1.lastIndexOf("."));
//		System.out.println(randString2);
		StringBuffer randString = new StringBuffer();
		for(int i=0;i<randString1.length();i++) {
			String rand = String.valueOf(randString1.charAt(i));
			randString.append(rand);
			graphic.setColor(new Color(20+random.nextInt(110),20+random.nextInt(110),20+random.nextInt(110)));
			graphic.drawString(rand,20*i+6, 60);
		}
//		for(int i=0;i<6;i++) {
//			String rand = String.valueOf(random.nextInt(10));
//			randString.append(rand);
//			graphic.setColor(new Color(20+random.nextInt(110),20+random.nextInt(110),20+random.nextInt(110)));
//			graphic.drawString(rand,20*i+6, 60);
//		}
		
		HttpSession session = req.getSession(true);
//		session.setAttribute("randstring", randString);
//		System.out.println(session.getAttribute("randstring"));
		System.out.println("載入一次");
		graphic.dispose();
		
		ImageIO.write(image, "JPEG", res.getOutputStream() );
	}
	
	public Color getRandColor(int fc,int bc) {
		Random random = new Random();
		if(fc>255) fc=255;
		if(bc>255) bc=255;
		int r=fc+random.nextInt(bc-fc);
		int g=fc+random.nextInt(bc-fc);
		int b=fc+random.nextInt(bc-fc);
		return new Color(r,g,b);
	}
	
	
}
