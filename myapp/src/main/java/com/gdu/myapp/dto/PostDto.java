package com.gdu.myapp.dto;

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
public class PostDto {
	private int postNo, hit;
	private String title, contents, tag;
	private Date createDt, modifyDt;
	private UserDto user;
}