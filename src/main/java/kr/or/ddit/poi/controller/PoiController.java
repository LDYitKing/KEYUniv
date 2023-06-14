package kr.or.ddit.poi.controller;

import java.io.FileInputStream;
import java.io.InputStream;
import java.security.Principal;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.tutition.service.TutitionService;
import kr.or.ddit.tutition.vo.TuitionVO;
import kr.or.ddit.tutition.vo.TutiPayVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/poi")
public class PoiController {
	@Inject
	private TutitionService tutiService;
	
	@Inject
	private TutitionService service;
	

    @GetMapping("/tuitionFee.do")
    public void tuitionFee(HttpServletRequest request, HttpServletResponse response,
    		@RequestParam("what") String tuitionNo,
    		Principal principal
    		) throws Exception {
    	TuitionVO tuti = tutiService.retriveTuti(tuitionNo);
    	
		
		TutiPayVO tutiPay = new TutiPayVO();
		tutiPay.setTuitionNo(tuti.getTuitionNo());
		tutiPay.setStuNo(tuti.getTuitionStuNo());
    	
		TutiPayVO tpvo = service.retrieveTutiPay(tutiPay);
		
		log.info("tpvo 서비스 실행 후 : {}", tpvo);
    	
        String filename = "";	// 내가 저장할 파일의 이름
        String formPath = request.getServletContext().getRealPath("/resources/excel/TuitionFee.xlsx"); // 양식파일 넣어두기 

        log.info("파일경로 {}", formPath);
        InputStream fis = new FileInputStream(formPath);
        XSSFWorkbook form_wb = new XSSFWorkbook(fis);
        XSSFSheet form_sheet = form_wb.getSheetAt(0);

        //양식에 넣어줄 데이터
        String a = tpvo.getColName(); // 단과대학
        String b =tpvo.getDeptName(); // 학과
        String c =tpvo.getStuNo(); // 학번
        String d =tpvo.getMemName(); // 이름
        String e = Integer.toString( tpvo.getTuitionAmount() ); // 등록금
        String f = Integer.toString( tpvo.getTuitionSchrec() ); // 수혜금액
        String g = Integer.toString( tpvo.getTuitionPayment() ); // 납입금액
        
        // 셀 스타일 생성
        CellStyle cellStyle = form_wb.createCellStyle();
        cellStyle.setBorderTop(BorderStyle.THIN);
        cellStyle.setBorderBottom(BorderStyle.THIN);
        cellStyle.setBorderLeft(BorderStyle.THIN);
        cellStyle.setBorderRight(BorderStyle.THIN);
        
        //엑셀 폼에 넣기 (로우와 셀 주의!!!)
        form_sheet.getRow(1).getCell(1).setCellValue(a);
        form_sheet.getRow(2).getCell(1).setCellValue(b);     
        form_sheet.getRow(3).getCell(1).setCellValue(c);   
        form_sheet.getRow(4).getCell(1).setCellValue(d);
        
	     // 텍스트를 숫자로 변환
	     int numericValue1 = Integer.parseInt(e);
	     // 변경할 값 계산
	     int newValue1 = numericValue1 * 10000;
	     // 변경된 값을 문자열로 변환하여 사용하거나 출력할 수 있습니다.
	     String formattedValue1 = String.format("%,d원", newValue1);
	     
	     // 텍스트를 숫자로 변환
	     int numericValue2 = Integer.parseInt(f);
	     // 변경할 값 계산
	     int newValue2 = numericValue2 * 10000;
	     // 변경된 값을 문자열로 변환하여 사용하거나 출력할 수 있습니다.
	     String formattedValue2 = String.format("%,d원", newValue2);
	     
	     // 텍스트를 숫자로 변환
	     int numericValue3 = Integer.parseInt(g);
	     // 변경할 값 계산
	     int newValue3 = numericValue3 * 10000;
	     // 변경된 값을 문자열로 변환하여 사용하거나 출력할 수 있습니다.
	     String formattedValue3 = String.format("%,d원", newValue3);
     
        form_sheet.getRow(3).getCell(3).setCellValue(formattedValue1);
        form_sheet.getRow(3).getCell(4).setCellValue(formattedValue2);
        form_sheet.getRow(3).getCell(5).setCellValue(formattedValue3);
        form_sheet.getRow(4).getCell(3).setCellValue(formattedValue1);
        form_sheet.getRow(4).getCell(4).setCellValue(formattedValue2);
        form_sheet.getRow(4).getCell(5).setCellValue(formattedValue3);
//        form_sheet.getRow(7).createCell(1).setCellValue(code);
//        form_sheet.getRow(8).createCell(1).setCellValue(text);
//        form_sheet.getRow(10).createCell(0).setCellValue(strNowDate);

        //form_sheet.getRow(10).createCell(0).setCellStyle();

        //파일 이름, 형식, 헤더 설정
        filename = "TuitionFee.xlsx";    // 파일 저장할 때 이름
        response.setContentType("ms-vnd/excel;charset=EUC-KR");
        response.setHeader("Content-Disposition", "attachment; filename=" + filename);
        form_wb.write(response.getOutputStream());
        form_wb.close();
    }




 

}
