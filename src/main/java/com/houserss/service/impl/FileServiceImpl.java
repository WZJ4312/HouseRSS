package com.houserss.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.houserss.service.IFileService;
import com.houserss.util.TimeUtils;

@Service("iFileService")
public class FileServiceImpl implements IFileService{
    private Logger logger = LoggerFactory.getLogger(FileServiceImpl.class);


    public String upload(MultipartFile file,String headFileName,String path){
        String fileName = file.getOriginalFilename();
        String uploadPath = path + "\\" +TimeUtils.getDayTime();
        //扩展名
        //abc.jpg
        String fileExtensionName = fileName.substring(fileName.lastIndexOf(".")+1);
        String uploadFileName = headFileName+"_"+UUID.randomUUID().toString()+"."+fileExtensionName;
        logger.info("开始上传文件,上传文件的文件名:{},上传的路径:{},新文件名:{}",fileName,uploadPath,uploadFileName);

        File fileDir = new File(uploadPath);
        if(!fileDir.exists()){
            fileDir.setWritable(true);
            fileDir.mkdirs();
        }
        File targetFile = new File(uploadPath,uploadFileName);
        try {
            file.transferTo(targetFile);
        } catch (IOException e) {
            logger.error("上传文件异常",e);
            return null;
        }
        return targetFile.getPath().substring(targetFile.getPath().indexOf("upload"));
    }


    @Override
    public void delete(List<String> deletes) {
        for (int i = 0; i < deletes.size(); i++) {
            File f = new File(deletes.get(i));
            if(f.exists()) {
                if(!f.delete()) {
                    logger.error("删除文件异常，文件名："+f.getName());
                }
            }
        }
    }
}
