package com.gdu.grafolioclone.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.grafolioclone.dto.LeaveUserDto;
import com.gdu.grafolioclone.dto.UserDto;

@Mapper
public interface UserMapper {
  UserDto getUserByMap(Map<String, Object> map);
	int insertUser(UserDto user);
	LeaveUserDto getLeaveUserBymap(Map<String, Object> map);
	int deleteUser(int userNo);
	
  int insertAccessHistory(Map<String, Object> map);
  int updateAccessHistory(String sessionId);
  
  // 전체 유저 수 - 최연승
  int getUserCount();
  
  // 기본 정보 수정 - 장윤수
  int updateUser(UserDto user);
  int updateUserExceptPw(UserDto user);
  
  // 프로필 정보 가져오기 - 오채원
  UserDto getProfileByUserNo(int userNo);
  
  // 프로필 목록 가져오기 - 최연승
  List<UserDto> getProfileList(Map<String, Object> map);
  
  // 팔로우 - 오채원
  int follow(Map<String, Object> map);
  
  // 언팔로우 - 오채원
  int unfollow(Map<String, Object> map);
  
  // 팔로우 조회 - 오채원
  int checkFollow(Map<String, Object> map);
  
  // 팔로잉 리스트 조회 - 오채원
  List<UserDto> fnGetFollowingList(Map<String, Object> map);
  // 팔로잉 개수 조회
  int fnGetFollowingCount(Map<String, Object> map);
  
  // 팔로잉 리스트 조회 - 오채원
  List<UserDto> fnGetFollowerList(Map<String, Object> map);
  // 팔로잉 개수 조회
  int fnGetFollowerCount(Map<String, Object> map);

  // 유저 검색
  int getSearchCount(Map<String, Object> map);
  List<UserDto> getSearchList(Map<String, Object> map);

}