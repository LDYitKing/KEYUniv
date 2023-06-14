package kr.or.ddit.univBoard.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UnivBoardImageUploadController {

	@Value("#{appInfo.univboardImages}")
	private File saveFolder;

	@Value("{appInfo.univboardImages}")
	private String folderURL;
	
	@PostConstruct
	public void init() {
		log.info("주입된 객체 : {}", saveFolder);
	}
	
	@RequestMapping(value="/univboard/imageUpload.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String,Object> imageUpload(MultipartFile upload,HttpServletRequest req) throws IOException{
		Map<String, Object> target = new HashMap<>();
		if(upload.isEmpty()) {
			Map<String,Object> error = new HashMap<>();
			target.put("error", error);
			error.put("number",400);
			error.put("message","업로드할 이미지가 없음");
		}else {
			String savename = UUID.randomUUID().toString();
			File saveFile = new File(saveFolder,savename);
			upload.transferTo(saveFile);
			target.put("fileName", upload.getOriginalFilename());
			target.put("uploaded",1);
			String url = String.format("%s,%s/%s", req.getContextPath(), folderURL, savename);
			target.put("url", url);
		}
		return target;
	}
}