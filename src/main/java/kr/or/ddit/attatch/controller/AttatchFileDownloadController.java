package kr.or.ddit.attatch.controller;

import java.io.File;
import java.io.IOException;
import java.util.Properties;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.attatch.service.AttatchFileGroupService;
import kr.or.ddit.attatch.view.AttatchDownloadView;
import kr.or.ddit.attatch.vo.AttatchFileVO;

@Controller
public class AttatchFileDownloadController {

	@Inject
	private AttatchFileGroupService service;
	
	@Inject
	private WebApplicationContext context;
	
	@Resource(name = "appInfo")
	private Properties appInfo;
	
	@RequestMapping("/{attType}/attatch/download.do") // 경로변수
	public AttatchDownloadView download(
			int atchId
			, int atchSeq
			, @PathVariable String attType
	) throws IOException {
		AttatchFileVO condition = new AttatchFileVO();
		condition.setAtchId(atchId);
		condition.setAtchSeq(atchSeq);
		
		String attatchPath = appInfo.getProperty(attType + ".attatchPath");
		
		//안전장치
		if(attatchPath==null) {
			throw new RuntimeException("파일이 저장 위치에 존재하지 않습니다.");
		}
		File saveFolder = context.getResource(attatchPath).getFile();
		
		AttatchFileVO atchFileVO = service.retrieveAttatchFile(condition, saveFolder);
		
		return new AttatchDownloadView() {
			
			@Override
			protected AttatchFileVO getModel() {
				return atchFileVO;
			}
		};
	}
}
