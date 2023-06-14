package kr.or.ddit.course.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.basket.service.BasketService;
import kr.or.ddit.basket.vo.BasketVO;
import kr.or.ddit.commons.dao.CommDAO;
import kr.or.ddit.course.service.CourseService;
import kr.or.ddit.course.vo.CourseVO;
import kr.or.ddit.department.dao.DepartmentDAO;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.lecture.service.LectureService;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.subject.service.SubjectService;
import kr.or.ddit.subject.vo.SubjectVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/sugang")
public class studentSignUpCourseController {
	
	
	@Inject
	private DepartmentDAO depDAO;
	@Inject
	private CommDAO commDAO;
	
	@Inject
	private LectureService lectService;
	@Inject
	private BasketService basketService;
	@Inject
	private CourseService courseService;
	@Inject
	private SubjectService subjectService;
	
	@ModelAttribute("basket")
	public BasketVO basket(Authentication authentication) {
//		log.info("authentication.getName() : {}", authentication.getName() );
		BasketVO basket = new BasketVO();
		basket.setStuNo(authentication.getName());
		return basket;
	}

	@ModelAttribute("course")
	public CourseVO course(Authentication authentication) {
		CourseVO course = new CourseVO();
		course.setStuNo(authentication.getName());
		return course;
	}
	
	@GetMapping("info")
	public String getUI() {
		return "sugang/info";
	}
	
	//----------------------------------- 장바구니
	
	@GetMapping("basket")
	public String getBasketUI(Model model) {
		model.addAttribute("deptList", depDAO.selectDepartmentList());
		model.addAttribute("colList", depDAO.selectColleageList());		
		model.addAttribute("commList", commDAO.selectCommList("A"));
		
		return "sugang/basket";
	}
	
	@PostMapping(value = "basket/lectures", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<LectureVO> lectList(LectureVO lecture) {
		log.info("lecture : {}", lecture );
		log.info("lecture.getSearchData() : {}", lecture.getSearchData());
		
		// 검색어 lecture 받아서(json) 보내기
		List<LectureVO> lectList = lectService.retrieveLectureList(lecture); 
		
		return lectList;
	}
	
	@PostMapping(value = "basket/lecture/{lectNo}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public LectureVO lectInfo(@PathVariable String lectNo) {
		LectureVO lecture = lectService.retrieveLecture(lectNo);
		lecture.setScoreCRTRList(lectService.retrieveCrtrList(lectNo));
		
		return lecture;
	}
	
	@PostMapping("basket/insert.do")
	@ResponseBody
	public String insertBasket(@ModelAttribute("basket") BasketVO basket) {
		log.info("modelAttribute basket : {}", basket);
		ServiceResult res = basketService.createBasket(basket);
		return res.toString();
	}
	
	@PostMapping("basket/delete.do")
	@ResponseBody
	public String deleteBasket(String basketNo) {
		log.info("delete basket no: {}", basketNo);
		ServiceResult res = basketService.removeBasket(basketNo);
		return res.toString();
	}
	
	@PostMapping("basket/list")
	@ResponseBody
	public List<BasketVO> selectBasketList(@ModelAttribute("basket") BasketVO basket){
		log.info("basket: {}", basket);
 		return basketService.retrieveBasketList(basket.getStuNo());
	}
	
	//----------------------------------- 내 즐겨찾기 과목 관련 개설강의 목록
	@PostMapping(value = "list/favorites")
	@ResponseBody
	public List<SubjectVO> selectFavoriteList(Authentication authentication){
		List<SubjectVO> favoriteList = subjectService.retrieveLectureWithFavorites(authentication.getName());
		log.info("favoriteList : {}", favoriteList);
		return favoriteList;
	}
	
	//----------------------------------- 수강신청
	@GetMapping("signup")
	public String getsugangUI(Model model) {
		model.addAttribute("deptList", depDAO.selectDepartmentList());
		model.addAttribute("colList", depDAO.selectColleageList());		
		model.addAttribute("commList", commDAO.selectCommList("A"));		
		
		return "sugang/signup";
	}
	
	@PostMapping("signup")
	@ResponseBody
	public String signup(@ModelAttribute("course") CourseVO course) {
		
		ServiceResult sr = courseService.createCourse(course);
		
		return sr.toString();
	}
	
	//----------------------------------- 수강신청 내역
	@GetMapping("list")
	public String getsugangListUI(Model model) {
		return "sugang/suganglist";
	}	
	
	@PostMapping(value = "list", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<CourseVO> selectCourseList(@ModelAttribute("course") CourseVO course) {
		course.setCourseState("I001"); // 수강중인 상태
		List<CourseVO> courseList = courseService.retrieveCourseList(course);
		return courseList;
	}
	
	@PostMapping("delete.do")
	@ResponseBody
	public void deleteCourse(CourseVO course) {
		int cnt = courseService.removeCourse(course);
	}

}



