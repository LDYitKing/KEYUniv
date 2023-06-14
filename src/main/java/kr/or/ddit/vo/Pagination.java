package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.ui.DefaultPaginationRenderer;
import kr.or.ddit.ui.PaginationRenderer;
import kr.or.ddit.ui.ReqPaginationRenderer;
import lombok.Getter;
import lombok.NoArgsConstructor;

/**
 * 페이징 처리에 필요한 속성들을 정의한 객체 -검색조건도 포함
 *
 */
@Getter
@NoArgsConstructor
public class Pagination<T> implements Serializable {
	
	public Pagination(int screenSize, int blockSize) {
		super();
		this.screenSize = screenSize;
		this.blockSize = blockSize;
	}
	
	private String pageUser;  //의연킴. why? 유저마다 페이징처리할때 편히 쓰기 위함.
	
	/**
	 * 세터는 필요함.
	 * @param pageUser
	 */
	public void setPageUser(String pageUser) {
		this.pageUser = pageUser;
	}
	
	
	private int totalRecord; // DB에서 조회
	
	private int screenSize=10; // 개발자가 결정
	// 사용자가 결정
	public void setScreenSize(int screenSize) {
		this.screenSize = screenSize;
	}
	private int blockSize=5;
	
	private int currentPage; // client - parameter
	
	// 연산 - immutable data
	private int totalPage;
	
	private int startRow;
	private int endRow;
	
	private int startPage;
	private int endPage;
	
	@JsonIgnore
	private transient PaginationRenderer renderer = new DefaultPaginationRenderer();
	@JsonIgnore
	private transient PaginationRenderer reqRenderer = new ReqPaginationRenderer();
	
	private List<T> dataList;
	
	private SimpleCondition simpleCondition = new SimpleCondition(); // 단순 키워드 검색 조건
	//킴의연 소행.
	private SimpleCondition reqSimpleCondition = new SimpleCondition(); // 단순 키워드 검색 조건
	private T detailCondition; // 상세 검색 
	
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		// totalPage
		totalPage = (totalRecord+(screenSize-1)) / screenSize;
	}
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
		
		// startRow, endRow -> currentPage, screenSize
		endRow = currentPage * screenSize;
		startRow = endRow - (screenSize - 1);
		
		// startPage, endPage -> currentPage, blockSize
		endPage = ((currentPage + (blockSize-1)) / blockSize) * blockSize;
		startPage = endPage - (blockSize - 1);
		
	}
	
	public void setRenderer(PaginationRenderer renderer) {
		this.renderer = renderer;
	}
	
	public String getPagingHTML() {
		return renderer.renderPagination(this);
	}
	
	public void setReqRenderer(PaginationRenderer reqRenderer) {
		this.reqRenderer = reqRenderer;
	}
	
	public String getReqPagingHTML() {
		return reqRenderer.renderPagination(this);
	}
	
	public void setDataList(List<T> dataList) {
		this.dataList = dataList;
	}
	
	public void setSimpleCondition(SimpleCondition simpleCondition) {
		this.simpleCondition = simpleCondition;
	}
	//킴 소행
	public void setReqSimpleCondition(SimpleCondition simpleCondition) {
		this.reqSimpleCondition = simpleCondition;
	}
	
	public void setDetailCondition(T detailCondition) {
		this.detailCondition = detailCondition;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
		
	}

}
