package com.feature.model;

public class FeatureVO implements java.io.Serializable{
	private String fea_no;
	private String fea_name;
	private String fea_det;
	
	public FeatureVO() {
		
	}
	
	public String getFea_no() {
		return fea_no;
	}
	public void setFea_no(String fea_no) {
		this.fea_no = fea_no;
	}
	public String getFea_name() {
		return fea_name;
	}
	public void setFea_name(String fea_name) {
		this.fea_name = fea_name;
	}
	public String getFea_det() {
		return fea_det;
	}
	public void setFea_det(String fea_det) {
		this.fea_det = fea_det;
	}
	
	
}
