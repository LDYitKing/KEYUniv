package kr.or.ddit.ui;

import kr.or.ddit.vo.Pagination;

public class ReqPaginationRenderer implements PaginationRenderer {

   private final String PATTERN
      = "<li class='page-item'><a class='page-link' href=':;' onclick='return fn_reqPaging(%d, event);'>%s</a></li>";
   
   @Override
   public String renderPagination(Pagination pagination) {
      int startPage = pagination.getStartPage();
      int endPage = pagination.getEndPage();
      int totalPage = pagination.getTotalPage();
      int lastPage = endPage > totalPage ? totalPage : endPage;
      int blockSize = pagination.getBlockSize();
      StringBuffer html = new StringBuffer();
      html.append("<ul class='pagination justify-content-center'>");
      if(startPage > blockSize) {
         html.append(
            String.format(PATTERN, startPage - blockSize, "이전" )
         );
         
      }
      
      for(int page = startPage; page <= lastPage; page++) {
         if(page == pagination.getCurrentPage()) {
            html.append(String.format(
                  "<li class='page-item active' aria-current='page'><span class='page-link'>%d</span></li>", page)
               );
         }else {
            html.append(
               String.format(PATTERN, page, page)
            );
         }
      }
      
      if(lastPage < totalPage) {
         html.append(
            String.format(PATTERN, lastPage + 1, "다음")
         );
      }
      
      html.append("</ul>");
      return html.toString();
   }

}