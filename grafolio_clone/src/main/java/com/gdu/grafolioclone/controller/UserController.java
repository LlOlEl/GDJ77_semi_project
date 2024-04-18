package com.gdu.grafolioclone.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gdu.grafolioclone.dto.UserDto;
import com.gdu.grafolioclone.service.UserService;


@RequestMapping("/user")
@Controller
public class UserController {

  private final UserService userService;

  public UserController(UserService userService) {
    super();
    this.userService = userService;
  }
  
  @GetMapping("/signin.page")
  public String signinPage(HttpServletRequest request
                         , Model model) {
    
  	// Sign In 페이지로 url 넘겨 주기 (로그인 후 이동할 경로를 의미함)
    model.addAttribute("url",  userService.getRedirectURLAfterSignin(request));
    
    model.addAttribute("naverLoginURL", userService.getNaverLoginURL(request));
    
    return "user/signin";
    
  }
  
  @PostMapping("/signin.do")
  public void signin(HttpServletRequest request, HttpServletResponse response) {
    userService.signin(request, response);
  }
  
  @GetMapping("/signup.page")
  public String signupPage() {
  	return "user/signup";
  }
  
  @GetMapping("/modify.page")
  public String modifyPage() {
    return "user/modify";
  }
  
  // 유저 프로필 가져오기 - 오채원
  @GetMapping("/profile.do")
  public String profilePage(HttpServletRequest request, Model model) {
    UserDto profile = userService.getProfileByUserNo(request);
    model.addAttribute("profile", profile);
    return "user/profile"; 
  }
  
  // 팔로우 - 오채원
  @PostMapping("/follow.do")
  public ResponseEntity<Map<String, Object>> follow(@RequestBody Map<String, Object> params, HttpSession session) {
    return userService.follow(params, session);
  }
  
  // 언팔로우 - 오채원
  @PostMapping("/unfollow.do")
  public ResponseEntity<Map<String, Object>> unfollow(@RequestBody Map<String, Object> params, HttpSession session) {
    return userService.unfollow(params, session);
  }
  
  // 팔로우 조회 - 오채원
  @PostMapping("/checkFollow.do")
  public ResponseEntity<Map<String, Object>> checkFollow(@RequestBody Map<String, Object> params, HttpSession session) {
    return userService.checkFollow(params, session);
  }
  
  // 팔로잉, 팔로워 수 조회 - 오채원
  @PostMapping("/getFollowCount.do")
  public ResponseEntity<Map<String, Object>> getFollowCount(@RequestBody Map<String, Object> params) {
    return userService.getFollowCount(params);
  }
  
  // 팔로잉 리스트 가져오기 - 오채원
  @PostMapping("/getFollowingList.do")
  public ResponseEntity<Map<String, Object>> getFollowingList(@RequestBody Map<String, Object> params) {
    return userService.fnGetFollowingList(params);
  }
  
  @PostMapping(value="/checkEmail.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> checkEmail(@RequestBody Map<String, Object> params){
  	return userService.checkEmail(params);
  }
  
  @PostMapping(value="/sendCode.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> sendCode(@RequestBody Map<String, Object> params){
  	return userService.sendCode(params);
  }
  
  @PostMapping("/signup.do")
  public void signup(HttpServletRequest request, HttpServletResponse response) {
    userService.signup(request, response);
  }
  
  @GetMapping("/leave.do")
  public void leave(HttpServletRequest request, HttpServletResponse response) {
    userService.leave(request, response);
  }
  
  @GetMapping("/signout.do")
  public void signout(HttpServletRequest request, HttpServletResponse response) {
    userService.signout(request, response);
  }
  
  @GetMapping("/naver/getAccessToken.do")
  public String getAccessToken(HttpServletRequest request) {
    String accessToken = userService.getNaverLoginAccessToken(request);
    return "redirect:/user/naver/getProfile.do?accessToken=" + accessToken;
  }
  
  @GetMapping("/naver/getProfile.do")
  public String getProfile(HttpServletRequest request, Model model) {
  	
  	// 네이버로부터 받은 프로필 정보
  	UserDto naverUser = userService.getNaverLoginProfile(request.getParameter("accessToken"));
  	
  	// 반환 경로
  	String path = null;
  	
  	// 프로필이 DB에 있는지 확인 (있으면 Sign In, 없으면 Sign Up)
  	if(userService.hasUser(naverUser)) {
  		// Sign In
  		userService.naverSignin(request, naverUser);
  		path = "redirect:/main.page";
  	} else {
  		// Sign Up(네이버 가입 화면으로 이동)
  		model.addAttribute("naverUser", naverUser);
  		path = "user/naver_signup";
  	}
  	
  	return path;
  }
  
  
  
  
  
  
  
  
  
  
  
  
}