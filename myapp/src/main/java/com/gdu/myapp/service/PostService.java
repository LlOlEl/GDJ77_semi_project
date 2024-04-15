package com.gdu.myapp.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.gdu.myapp.dto.PostDto;

public interface PostService {
	ResponseEntity<Map<String, Object>> summernoteImageUpload(MultipartFile multipartFile);
	int registerPost(HttpServletRequest request);
	ResponseEntity<Map<String, Object>> getPostList(HttpServletRequest request);
	int updateHit(int postNo);
	PostDto getPostByNo(int postNo);
	int registerComment(HttpServletRequest request);
	Map<String, Object> getCommentList(HttpServletRequest request);
	int registerReply(HttpServletRequest request);
	int removeComment(int commentNo);
}
