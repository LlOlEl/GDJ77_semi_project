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
public class PostDto {
	private int postNo, hit, category;
	private String title, contents;
	private Date createDt, modifyDt;
	private UserDto user;
}