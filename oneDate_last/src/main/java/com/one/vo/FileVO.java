package com.one.vo;

import org.springframework.web.multipart.MultipartFile;

public class FileVO {

	private String title;
//	private MultipartFile multipart;
//	private String fileName;
	private MultipartFile[] multipart;
	private String[] filenames;
	
	public MultipartFile[] getMultipart() {
		return multipart;
	}
	public void setMultipart(MultipartFile[] multipart) {
		this.multipart = multipart;
	}
	public String[] getFilenames() {
		return filenames;
	}
	public void setFilenames(String[] filenames) {
		this.filenames = filenames;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
//	public MultipartFile getMultipart() {
//		return multipart;
//	}
//	public void setMultipart(MultipartFile multipart) {
//		this.multipart = multipart;
//	}
//	public String getFileName() {
//		return fileName;
//	}
//	public void setFileName(String fileName) {
//		this.fileName = fileName;
//	}
	
}
