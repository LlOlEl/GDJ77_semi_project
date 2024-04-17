package com.gdu.grafolioclone.mapper;

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
  
  // 프로필 정보 가져오기
  UserDto getProfileByUserNo(int userNo);
  
  // 팔로우
  int follow(Map<String, Object> map);
  
  // 언팔로우
  int unfollow(Map<String, Object> map);
  
  // 팔로우 조회
  int checkFollow(Map<String, Object> map);
  
  
  
}
