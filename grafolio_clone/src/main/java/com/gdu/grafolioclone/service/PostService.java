package com.gdu.grafolioclone.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.multipart.MultipartFile;

import com.gdu.grafolioclone.dto.PostDto;

public interface PostService {
	ResponseEntity<Map<String, Object>> summernoteImageUpload(MultipartFile multipartFile);
	int registerPost(HttpServletRequest request);
	ResponseEntity<Map<String, Object>> getPostList(HttpServletRequest request);
	int updateHit(int postNo);
	PostDto getPostByNo(int postNo);
	int modifyPost(PostDto post);
	int deletePost(int postNo);
	int registerComment(HttpServletRequest request);
	Map<String, Object> getCommentList(HttpServletRequest request);
	int registerReply(HttpServletRequest request);
	int removeComment(int commentNo);
	int registerLike(Map<String, Object> params);
	int removeLike(Map<String, Object> params);
	int getLikeCount(int postNo);
	int getLikeCountByUserNo(int userNo);
	int getHitCountByUserNo(int userNo);
	int checkLikeStatus(int postNo, int userNo);
	
  // 유저프로필 - 업로드한 게시글 가져오기(오채원)
	ResponseEntity<Map<String, Object>> getUserUploadList(HttpServletRequest request);
}
