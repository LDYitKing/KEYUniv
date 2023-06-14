package kr.or.ddit.attatch.view;

import java.io.File;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.web.servlet.view.AbstractView;

import kr.or.ddit.attatch.vo.AttatchFileVO;

public abstract class AttatchDownloadView extends AbstractView {
	
	protected abstract AttatchFileVO getModel();
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse resp) throws Exception {
		
//		Content-Disposition: attatchment [inline:default]; filename=""
//		application/octet-stream
		
		AttatchFileVO atchFile = getModel();
		
		String originalfilename = atchFile.getAtchOrginName();
		File saveFile = atchFile.getAtchFile();
		if (!saveFile.exists()) {
			resp.sendError(404, String.format("%s 해당 파일은 존재하지 않습니다.", originalfilename));
			return;
		}
		
		String encodedName = URLEncoder.encode(originalfilename, "UTF-8")
						.replace("+", " ");
		
		resp.setHeader("Content-Disposition", String.format("attatchment;filename=\"%s\"", encodedName));
		resp.setContentType("application/octet-stream"); // 기본 2진데이터 (binary data)
		resp.setContentLengthLong(atchFile.getAtchSize());
		try (
			OutputStream os = resp.getOutputStream();
		){
			FileUtils.copyFile(saveFile, os);
		}
	}

}
