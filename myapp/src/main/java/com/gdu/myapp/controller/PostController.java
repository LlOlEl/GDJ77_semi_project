package com.gdu.myapp.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.myapp.service.PostService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/post")
@RequiredArgsConstructor
@Controller
public class PostController {

	private final PostService postSerivce;
	
	@GetMapping("/list.page")
	public String list() {
		return "post/list";
	}
	
	@GetMapping("/write.page")
	public String writePage() {
		return "post/write";
	}
	
	@PostMapping(value="/summernote/imageUpload.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> summernoteImageUpload(@RequestParam("image") MultipartFile multipartFile){
		return postSerivce.summernoteImageUpload(multipartFile);
	}
	
	@PostMapping("/register.do")
	public String register(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("insertCount", postSerivce.registerPost(request));
		return "redirect:/post/list.page";
	}
	
	@GetMapping(value="/getPostList.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> getPostList(HttpServletRequest request) {
		System.out.println(request.getParameter("category"));
		return postSerivce.getPostList(request);
	}
	
	@GetMapping("/updateHit.do")
	public String updateHit(@RequestParam int postNo) {
		postSerivce.updateHit(postNo);
		return "redirect:/post/detail.do?postNo=" + postNo;
	}
	
	@GetMapping("/detail.do")
	public String detail(@RequestParam int postNo, Model model) {
		model.addAttribute("post", postSerivce.getPostByNo(postNo));
		return "post/detail";
	}
	
	@PostMapping(value="/registerComment.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> registerComment(HttpServletRequest request) {
		return new ResponseEntity<>(Map.of("insertCount", postSerivce.registerComment(request))
														  , HttpStatus.OK);
	}
	
	@GetMapping(value="/comment/list.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> commentList(HttpServletRequest request) {
		/*
		 * return new ResponseEntity<>(postSerivce.getCommentList(request) ,
		 * HttpStatus.OK);
		 */
		return ResponseEntity.ok(postSerivce.getCommentList(request));
	}
	
	@PostMapping(value="/registerReply.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> registerReply(HttpServletRequest request) {
		return new ResponseEntity<>(Map.of("insertCount", postSerivce.registerReply(request))
														  , HttpStatus.OK);
	}
	
	@GetMapping("/removeComment.do")
	public String removeComment(@RequestParam("commentNo") int commentNo,
															@RequestParam("postNo") int postNo) {
		postSerivce.removeComment(commentNo);
		return "redirect:/post/detail.do?postNo=" + postNo;
	}
	
  @PostMapping("/edit.do")
  public String edit(@RequestParam int postNo, Model model) {
    model.addAttribute("post", postSerivce.getPostByNo(postNo));
    return "post/edit";
  }
}