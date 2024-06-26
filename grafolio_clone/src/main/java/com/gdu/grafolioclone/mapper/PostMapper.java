package com.gdu.grafolioclone.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.grafolioclone.dto.CommentDto;
import com.gdu.grafolioclone.dto.LikeDto;
import com.gdu.grafolioclone.dto.PostDto;

@Mapper
public interface PostMapper {
  int insertPost(PostDto post);
  int getPostCount();
  List<PostDto> getPostList(Map<String, Object> map);
  List<PostDto> getPostListByCategory(Map<String, Object> map);
  int updateHit(int postNo);
  PostDto getPostByNo(int postNo);
  int updatePost(PostDto post);
  int removePost(int postNo);
  int insertComment(CommentDto comment);
  int getCommentCount(int postNo);
  List<CommentDto> getCommentList(Map<String, Object> map);
  int insertReply(CommentDto comment);
  int removeComment(int commentNo);
  int removeCommentByPostNo(int postNo);
  int insertLike(LikeDto like);
  int removeLike(LikeDto like);
  int getLikeCountByPostNo(int postNo);
  int getLikeCountByUserNo(int userNo);
  int getHitCountByUserNo(int userNo);
  int checkLikeStatus(LikeDto like);
  
  // 포스트 검색 메소드
  int getSearchCount(Map<String, Object> map);
  List<PostDto> getSearchList(Map<String, Object> map);
  
  // 유저프로필 - 업로드한 게시글 가져오기(오채원)
  List<PostDto> getUserUploadList(Map<String, Object> map);
  // 유저 프로필 - 업로드한 게시글 개수
  int getUserUploadCount(int userNo);
  
  // 유저프로필 - 좋아요한 게시글 가져오기(오채원
  List<PostDto> getUserLikeListByUserNo(Map<String, Object> map);
  // 유저프로필 - 좋아요한 게시글 개수
  int getUserLikeCountByUserNo(int userNo);
  
  // 게시물 상세- 댓글수(김규식)
  int getCommentCountByPostNo(int postNo);
  // 게시물 상세- 조회수(김규식)
  int getHitCountByPostNo(int postNo);
}
