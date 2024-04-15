package com.gdu.myapp.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.gdu.myapp.dto.PostDto;

public interface PostService {
	ResponseEntity<Map<String, Object>> summernoteImageUpload(MultipartFile multipartFile);
	int registerBlog(HttpServletRequest request);
	ResponseEntity<Map<String, Object>> getBlogList(HttpServletRequest request);
	int updateHit(int blogNo);
	PostDto getBlogByNo(int blogNo);
	int registerComment(HttpServletRequest request);
	Map<String, Object> getCommentList(HttpServletRequest request);
	int registerReply(HttpServletRequest request);
	int removeComment(int commentNo);
}
