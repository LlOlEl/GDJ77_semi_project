package com.gdu.grafolioclone.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class LikeDto {
	private int likeNo, postNo, userNo;
	private Date createDt;
}
