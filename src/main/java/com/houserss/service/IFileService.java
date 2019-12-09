package com.houserss.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public interface IFileService {
    String upload(MultipartFile file,String HeadFileName,String path);
    
    void delete(List<String> deletes);
}
