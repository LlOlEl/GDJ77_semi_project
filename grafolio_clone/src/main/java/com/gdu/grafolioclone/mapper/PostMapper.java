package com.gdu.grafolioclone.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.grafolioclone.dto.PostDto;
import com.gdu.grafolioclone.dto.CommentDto;

@Mapper
public interface PostMapper {
  int insertPost(PostDto post);
  int getPostCount();
  List<PostDto> getPostList(Map<String, Object> map);
  List<PostDto> getPostListByCategory(Map<String, Object> map);
  int updateHit(int postNo);
  PostDto getPostByNo(int postNo);
  int insertComment(CommentDto comment);
  int getCommentCount(int postNo);
  List<CommentDto> getCommentList(Map<String, Object> map);
  int insertReply(CommentDto comment);
  int removeComment(int commentNo);
}
