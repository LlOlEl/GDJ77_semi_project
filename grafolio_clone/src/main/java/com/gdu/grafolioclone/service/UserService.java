package com.gdu.grafolioclone.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.grafolioclone.dto.UserDto;

public interface UserService {
	
	// 가입 및 탈퇴
	ResponseEntity<Map<String, Object>> checkEmail(Map<String, Object> params);
	ResponseEntity<Map<String, Object>> sendCode(Map<String, Object> params);
	void signup(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
	void leave(HttpServletRequest request, HttpServletResponse response);
	
	// 로그인 및 로그아웃
	String getRedirectURLAfterSignin(HttpServletRequest request);
	void signin(HttpServletRequest request, HttpServletResponse response);
	void signout(HttpServletRequest request, HttpServletResponse response);
  
  // 네이버 로그인
	String getNaverLoginURL(HttpServletRequest request);
  String getNaverLoginAccessToken(HttpServletRequest request);
  UserDto getNaverLoginProfile(String accessToken);
  boolean hasUser(UserDto user);
  void naverSignin(HttpServletRequest request, UserDto naverUser);
  
  int modifyUser(MultipartHttpServletRequest multipartRequest);
  
  // 수정 페이지에 사용자 정보 가져오기
  // 프로필 정보 가져오기 - 오채원
  UserDto getProfileByUserNo(HttpServletRequest request);
  // 프로필 목록 가져오기 - 최연승
  ResponseEntity<Map<String, Object>> getProfileList(HttpServletRequest request);
  // 팔로우 - 오채원
  ResponseEntity<Map<String, Object>> follow(Map<String, Object> params, HttpSession session);
  // 언팔로우 - 오채원
  ResponseEntity<Map<String, Object>> unfollow(Map<String, Object> params, HttpSession session);
  // 팔로우 조회 - 오채원
  ResponseEntity<Map<String, Object>> checkFollow(Map<String, Object> params, HttpSession session);
  // 팔로잉, 팔로워 개수 조회 - 오채원
  ResponseEntity<Map<String, Object>> getFollowCount(Map<String, Object> params);
  // 팔로잉 리스트 조회 - 오채원
  ResponseEntity<Map<String, Object>> fnGetFollowingList(Map<String, Object> params, HttpSession session);
  // 팔로우 리스트 조회 - 오채원
  ResponseEntity<Map<String, Object>> fnGetFollowerList(Map<String, Object> params, HttpSession session);
  
  // 프로필 검색
  ResponseEntity<Map<String, Object>> searchCreators(HttpServletRequest request);
  
}