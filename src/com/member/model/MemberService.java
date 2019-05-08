package com.member.model;

import java.util.List;

public class MemberService {
	private MemberDAO_interface dao;

	public MemberService() {
		dao = new MemberJDBCDAO();
	}

	public MemberVO addMember(String mem_name, String mem_account, String mem_pwd, String mem_gender,
			String mem_mail, String mem_id, String mem_tel, String mem_status, byte[] mem_pic, Double mem_balance,
			String mem_nickname) {
		MemberVO memberVO = new MemberVO();
		memberVO.setMem_name(mem_name);
		memberVO.setMem_account(mem_account);
		memberVO.setMem_pwd(mem_pwd);
		memberVO.setMem_gender(mem_gender);
		memberVO.setMem_mail(mem_mail);
		memberVO.setMem_id(mem_id);
		memberVO.setMem_tel(mem_tel);
		memberVO.setMem_status(mem_status);
		memberVO.setMem_pic(mem_pic);
		memberVO.setMem_balance(mem_balance);
		memberVO.setMem_nickname(mem_nickname);

		dao.insert(memberVO);
		
		return memberVO;

	}

	public MemberVO updateMember(String mem_name,String mem_pwd, String mem_gender,
			String mem_mail, String mem_tel, String mem_status, byte[] mem_pic, Double mem_balance,
			String mem_nickname,String mem_account) {
		MemberVO memberVO = new MemberVO();
		memberVO.setMem_name(mem_name);
		memberVO.setMem_pwd(mem_pwd);
		memberVO.setMem_gender(mem_gender);
		memberVO.setMem_mail(mem_mail);
		memberVO.setMem_tel(mem_tel);
		memberVO.setMem_status(mem_status);
		memberVO.setMem_pic(mem_pic);
		memberVO.setMem_balance(mem_balance);
		memberVO.setMem_nickname(mem_nickname);
		memberVO.setMem_account(mem_account);
		
		dao.update(memberVO);

		return memberVO;
	}
	
	public MemberVO updateMemberWithoutPic(String mem_name,String mem_pwd,
			String mem_mail, String mem_tel, String mem_status, Double mem_balance,
			String mem_nickname,String mem_account,String mem_no) {
		MemberVO memberVO = new MemberVO();
		memberVO.setMem_name(mem_name);
		memberVO.setMem_pwd(mem_pwd);
		memberVO.setMem_mail(mem_mail);
		memberVO.setMem_tel(mem_tel);
		memberVO.setMem_status(mem_status);
		memberVO.setMem_balance(mem_balance);
		memberVO.setMem_nickname(mem_nickname);
		memberVO.setMem_account(mem_account);
		memberVO.setMem_no(mem_no);
		
		dao.updateWithoutPic(memberVO);

		return memberVO;
	}
	
	public MemberVO updateBalance(Double mem_balance,String mem_no) {
		MemberVO memberVO = new MemberVO();
		memberVO.setMem_balance(mem_balance);
		memberVO.setMem_no(mem_no);
		
		dao.updateBalance(memberVO);

		return memberVO;
	}

	public int deleteMember(String mem_no) {
		return dao.delete(mem_no);
	}

	public MemberVO getOneMember(String mem_no) {
		return dao.findByPrimaryKey(mem_no);
	}
	
	public MemberVO getOneMemberByAccount(String mem_account) {
		return dao.findByMem_account(mem_account);
	}
	
	public List<MemberVO> getOneMemberByNickname(String mem_nickname) {
		return dao.findByMem_nickname(mem_nickname);
	}
	
	public List<MemberVO> getOneMemberByName(String mem_name) {
		return dao.findByMem_name(mem_name);
	}

	public List<MemberVO> getAll(){
		return dao.getAll();
	}
}
