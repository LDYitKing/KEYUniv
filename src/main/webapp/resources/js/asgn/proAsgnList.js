/**
 * 
 */
let asgnBody = $("#asgnBody");
let viewUrlIni = asgnBody.data("viewUrl");
let cPath = asgnBody.data("cpath");
let btnSpace = $(".btnSpace");
var queryString = window.location.search;
queryString = queryString.substring(1);
var param = {};
param = queryString.split("=");
console.log(param[1]);
var lectNo = param[1];


/* tr Tag만들기 */
let fn_makeTr = function(asgn){
   /* 과제 상세보기로 이동하는 a태그 만들기 */
   let aTag = $("<a>").attr("href", `javascript:fn_detail('${asgn.asgnNo }')`)
                  .html(asgn.asgnNo);

   /* 과제리스트 tr */
   return $("<tr>").append(
      $("<td>").html(aTag)
         , $("<td>").html(asgn.asgnName)
         , $("<td>").html(asgn.asgnRdate)
         , $("<td>").html(asgn.asgnDdate)
         , $("<td>").html(asgn.lectName)
         , $("<td>").append($("<button>").addClass("btn btn-sm btn-success").text("제출 현황").on("click",function(){
               location.href = `${cPath}/asgn/proStuAsgnView.do?what=${asgn.asgnNo}&lect=${asgn.lectNo}`;
         })
      )
   );
}

/* ajax로 비동기 요청보내기 */
let listForm = $("[name=listForm]").on("submit", function(event){
   event.preventDefault();
   let url = this.action;
   let method = this.method;
   $.ajax({
      url : url,
      method : method,
      dataType : "json"
   }).done(function(resp, textStatus, jqXHR) {
      console.log(resp);
      asgnBody.empty();

      let trTags = [];
      if(resp.length > 0){
         $.each(resp, function(idx, asgn){
            trTags.push( fn_makeTr(asgn) );
            console.log("asgn", asgn);
         });
      } else{
         trTags.push($("<tr>").html($("<td colspan='5'>").html("과제가 없습니다.")));
      }
      asgnBody.append(trTags);
   });
   return false;
}).submit();

let detailAsgn = $(".detailAsgn");
let detailView = $(".detailView");
/* 과제 상세보기 table 만들기 */
let fn_makeTable = function(realAsgnSub){
   let detailtrTags = [];
   detailtrTags.push($("<tr>").append(
         $("<th>").html("과제내용")
         , $("<td>").html(realAsgnSub.asgnContent)
      )
   )

   let file;
   if(realAsgnSub.asgnFile==null){
      file = "첨부파일 없음";
   }else{
      /* 교수가 첨부파일 넣는 곳. url넣기 */
      file = realAsgnSub.asgnFile;
   }
   detailtrTags.push($("<tr>").append(
         $("<th>").html("첨부파일")
         , $("<td>").html(file)
      )
   )
   return detailtrTags;
}

/* 과제 상세보기 데이터 가져오기 */
let fn_detail = function(asgnNo){
   console.log("클릭?"+asgnNo);

   /* ajax요청으로 과제 상세보기 */
   let viewUrl = `${cPath}/asgn/proAsgnView.do?what=${asgnNo}`;
   let viewMethod = "get"
   $.ajax({
      url : viewUrl,
      method : viewMethod,
      dataType : "json"
   }).done(function(resp, textStatus, jqXHR){
      console.log("asgnNo:"+resp.asgnNo);
      let realAsgnSub = resp;
      detailView.empty();
      detailView.append( fn_makeTable(realAsgnSub) );
      detailAsgn.show();
   });
};



















