package com.vendor.model;

import java.util.List;

public class VendorService {
	
	private VendorDAO_interface dao;
	
	public VendorService() {
		dao = new VendorDAO();
	}
	

	
	public VendorVO addV(String v_account, String v_pwd, String v_mail, String v_tel, String v_n_code, String v_ad_code, String v_address1,String v_address2,String v_address3,String v_name,byte[] v_pic) {
		VendorVO vVO = new VendorVO();
		
		vVO.setV_account(v_account);
		vVO.setV_pwd(v_pwd);
		vVO.setV_mail(v_mail);
		vVO.setV_tel(v_tel);
		vVO.setV_n_code(v_n_code);
		vVO.setV_ad_code(v_ad_code);
		vVO.setV_address1(v_address1);
		vVO.setV_address2(v_address2);
		vVO.setV_address3(v_address3);
		vVO.setV_name(v_name);
		vVO.setV_pic(v_pic);
		
		dao.create(vVO);
		return vVO;
	}
	
	public VendorVO update(String v_type,String v_start_time,String v_end_time,String v_day,String v_tables,String v_text,String vendor_no) {
		VendorVO vVO = new VendorVO();
		
		vVO.setV_type(v_type);
		vVO.setV_start_time(v_start_time);
		vVO.setV_end_time(v_end_time);
		vVO.setV_day(v_day);
		vVO.setV_tables(v_tables);
		vVO.setV_text(v_text);
		vVO.setVendor_no(vendor_no);
		
		dao.update(vVO);
		return vVO;
	}
	
	
	public VendorVO updatePic(byte[] v_pic,String vendor_no) {
		VendorVO vVO = new VendorVO();
		vVO.setV_pic(v_pic);
		vVO.setVendor_no(vendor_no);
		
		dao.updatePic(vVO);
		return vVO;
	}
	
	public VendorVO updateAd(byte[] v_ad,String vendor_no) {
		VendorVO vVO = new VendorVO();
		vVO.setV_ad(v_ad);
		vVO.setVendor_no(vendor_no);
		
		dao.updateAd(vVO);
		return vVO;
	}
	
	
	public VendorVO findByAcc(String v_account) {
		return dao.findByAcc(v_account);
	}
	
	public VendorVO findByPK(String vendor_no) {
		return dao.findByPK(vendor_no);
	}
	
	public List<VendorVO> getAll() {
		return dao.getAll();
	}
	
	public List<VendorVO> findByType(String v_type) {
		return dao.findByType(v_type);
	}
	
	public List<VendorVO> search(String v_name, String address1, String address2,String address3){
		return dao.search(v_name, address1, address2, address3);
	}
	
	public void upStatus(String v_status,String vendor_no) {
		VendorVO vVO = new VendorVO();
		vVO.setV_status(v_status);
		vVO.setVendor_no(vendor_no);
		
		dao.upStatus(vVO);
	}
	
	public void upWallet(String v_wallet,String vendor_no) {
		VendorVO vVO = new VendorVO();
		vVO.setV_wallet(v_wallet);;
		vVO.setVendor_no(vendor_no);
		
		dao.upWallet(vVO);
	}
}
