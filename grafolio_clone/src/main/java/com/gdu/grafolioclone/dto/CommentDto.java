package com.gdu.grafolioclone.dto;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class CommentDto {
	private int commentNo, depth, groupNo, postNo, state;
	private String contents;
	private Date createDt;
	private UserDto user;
}
