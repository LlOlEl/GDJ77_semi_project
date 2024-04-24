package com.gdu.grafolioclone.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gdu.grafolioclone.service.PostService;
import com.gdu.grafolioclone.service.UserService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/search")
@RequiredArgsConstructor
@Controller
public class SearchController {

	private final UserService userService;
	private final PostService postService;
	
	@GetMapping("")
	public String search(HttpServletRequest request, Model model) {
		model.addAttribute("q", request.getParameter("q"));
		return "search/search";
	}	
	
  @GetMapping(value="/projects", produces="application/json")
  public ResponseEntity<Map<String, Object>> searchProjects(HttpServletRequest request) {
      // 검색 로직 구현
      return postService.searchPosts(request);
  }

  @GetMapping(value="/creators", produces="application/json")
  public ResponseEntity<Map<String, Object>> searchCreators(HttpServletRequest request) {
      // 검색 로직 구현
      return userService.searchCreators(request);
  }
	
}
