package com.gdu.grafolioclone.utils;

import java.io.File;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component
public class MyFileUtils {

  // 현재 날짜
  public static final LocalDate TODAY = LocalDate.now();
  
  // 업로드 경로 반환
  public String getUploadPath() {
    return "/upload" + DateTimeFormatter.ofPattern("/yyyy/MM/dd").format(TODAY);
  }
  
  // 미니 프로필 경로 반환
  public String getMiniProfilePath() {
    return "/profile/mini" + DateTimeFormatter.ofPattern("/yyyy/MM/dd").format(TODAY);
  }
  
  // 메인 프로필 경로 반환
  public String getMainProfilePath() {
    return "/profile/main" + DateTimeFormatter.ofPattern("/yyyy/MM/dd").format(TODAY);
  }
  
  // 저장될 파일명 반환
  public String getFilesystemName(String originalFilename) {
    String extName = null;
    if(originalFilename.endsWith(".tar.gz")) {
      extName = ".tar.gz";
    } else {
      extName = originalFilename.substring(originalFilename.lastIndexOf("."));
    }
    return UUID.randomUUID().toString().replace("-", "") + extName;
  }
  
  // 임시 파일 경로 반환
  public String getTempPath() {
  	return "/temporary"; 
  }
  
  // 임시 파일 이름 반환 (확장자 제외)
  public String getTempFileName() {
  	return System.currentTimeMillis() + "";
  }
  
  // profile 파일 저장 & DB에 저장할 파일 경로된 profilePicturePath 생성 - 장윤수
  public String updateProfilePicture(MultipartHttpServletRequest multipartRequest, String paramName) {
    
    MultipartFile profile = multipartRequest.getFile(paramName);
    
    String profilePicturePath = "";
    
    if(profile != null && !profile.isEmpty() && profile.getSize() > 0) {
      StringBuilder builder = new StringBuilder();
      String uploadPath = null;
      if(paramName == "miniProfilePicturePath") {
        uploadPath = getMiniProfilePath();
      } else {
        uploadPath = getMainProfilePath();
      }
      File dir = new File(uploadPath);
      if(!dir.exists()) {
        dir.mkdirs();
      }
      String originalFilename = profile.getOriginalFilename();
      String filesystemName = getFilesystemName(originalFilename);
      profilePicturePath = builder.append("<img src=\"").append(multipartRequest.getContextPath()).append(uploadPath).append(filesystemName).append("\">").toString();
      builder.setLength(0);
      
      File file = new File(dir, filesystemName);
      
      try {
        profile.transferTo(file);
        
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
    
    return profilePicturePath;
  }
  
  
  
}