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
public class FollowDto {
  private int followNo, fromUser, toUser;
  private Date createDt;
}
