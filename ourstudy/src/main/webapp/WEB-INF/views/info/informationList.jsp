<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%-- 로그인 된 경우에만 글쓰기버튼 활성화 --%>
<!DOCTYPE html>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/information3.css">  
<body> 
   <div class="page-main">   
      <div class="content-main"><!-- 전체 화면의 87% -->
         <!-- 사이드바 오른쪽 화면 시작 -->
         <div class="content-right">
            <h3 style="text-align:center"><b>안내사항</b></h3>
            <!-- 검색폼 시작 -->
            <div class="section" style="text-align:center"> 
               <div class="search-bar">
                  <form class="search-form d-flex align-items-center" action="informationList.do" method="get"><!-- 자동 인코딩 처리를 위해 -->
                     <select class="form-select" id="form-select1" name="keyfield" aria-label="form-select">
                        <option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>제목</option>
                        <option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>내용</option>
                     </select> 
                     <!--                            //검색했을 때 값이 남아있게 하기 위해서 -->
                     <!--                            //자기자신에게 값을 보내기 때문에 param 이용 -->
                     <input type="text" name="keyword" value="${param.keyword}" placeholder="제목 또는 내용 검색">
                     <button type="submit" title="Search"><i class="bi bi-search"></i></button>
                  </form>
               </div>
            </div>
            <!-- 검색폼 끝 -->
            <div class="align-right">
               <c:if test="${!empty user && user.mem_auth == 9}">
               <button type="button" class="btn btn-secondary btn-sm"   
                     onclick="location.href='infoWrite.do'">글작성</button>
               </c:if>
            </div>                        
            <!-- table 시작 -->
            <div class="content-margin my-5">
            <c:if test="${countimport == 0 && count == 0}">
            <table class="table table-group-divider align-center">
               <tr>
                  <td>표시할 안내사항이 없습니다</td>
               </tr>
            </table>
            </c:if>

               <!-- 공지글 시작 -->
               <c:if test="${countimport > 0 && count == 0}">
                  <table class="table table-hover align-center" id="t1">
                     <thead class="table-head">
                        <tr>
                           <th scope="col" width="20%">번호<br></th>
                           <th scope="col" width="40%">제목</th>
                           <th scope="col" width="40%">작성일</th>
                        </tr>
                     </thead>
                     <tbody class="table-body table-group-divider">
                     <c:forEach var="importinfo" items="${informationImportList}">
                        <tr>
                           <c:if test="${importinfo.info_pin == 0}">
                              <th scope="row">${importinfo.info_num}</th>
                           </c:if>
                           <c:if test="${importinfo.info_pin == 1}">
                              <!-- <th scope="row"class="blink"><span style="color:#ffc400">★★★</span><span style="color:#097bd9">필독</span><span style="color:#ffc400">★★★</span></th> -->
                              <th scope="row" class="blink"><span
                                 style="color: #ffc400">★</span><span style="color: #097bd9">필독</span><span
                                 style="color: #ffc400">★</span></th>
                           </c:if>
                           <td class="text-left"><a
                              href="infoDetail.do?info_num=${importinfo.info_num}"
                              class="truncate-text">${importinfo.info_title}</a></td>
                           <td>${importinfo.info_date}</td>
                        </tr>
                     </c:forEach>
                     </tbody>
                  </table>
               </c:if>
               <!-- 공지글 끝 -->
               <c:if test="${count>0}">
               <table class="table table-hover align-center"  id="t1">
                  <thead class="table-head">
                     <tr>
                        <th scope="col" width="20%">번호<br></th>
                        <th scope="col" width="40%">제목</th>
                        <th scope="col" width="40%">작성일</th>
                     </tr>                     
                  </thead>
                  <tbody class="table-body table-group-divider">
                     <!-- 공지글 시작 -->
                      <c:if test="${countimport > 0}">
                     <c:forEach var="importinfo" items="${informationImportList}">
                     <tr>
                        <c:if test="${importinfo.info_pin == 0}">
                        <th scope="row">${importinfo.info_num}</th>
                        </c:if>   
                        <c:if test="${importinfo.info_pin == 1}">
                        <!-- <th scope="row"class="blink"><span style="color:#ffc400">★★★</span><span style="color:#097bd9">필독</span><span style="color:#ffc400">★★★</span></th> -->
                        <th scope="row"class="blink"><span style="color:#ffc400">★</span><span style="color:#097bd9">필독</span><span style="color:#ffc400">★</span></th>
                        </c:if>   
                        <td class="text-left">
                           <a href="infoDetail.do?info_num=${importinfo.info_num}" class="truncate-text">${importinfo.info_title}</a>
                        </td>
                        <td >${importinfo.info_date}</td>       
                     </tr>
                     </c:forEach>         
                     </c:if>
                     <!-- 공지글 끝 -->
                     <!-- 일반글(필독제외 시작) -->
                     <c:forEach var="info" items="${informationList}"><!-- var는 자바빈(VO) -->
                     <tr>
                        <c:if test="${info.info_pin == 0}">
                        <th scope="row">${info.info_num}</th>
                        </c:if>   
                        <c:if test="${info.info_pin == 1}">
                        <th scope="row"><span style="color:#ffc400">★</span><span style="color:#097bd9">필독</span><span style="color:#ffc400">★</span></th>
                        </c:if>
                        <td class="text-left">
                           <a href="infoDetail.do?info_num=${info.info_num}" class="truncate-text">${info.info_title}</a>
                        </td>
                        <td>${info.info_date}</td>                                                 
                     </tr>
                     </c:forEach>
                     <!-- 일반글(필독제외 끝) -->                  
                  </tbody>
               </table>
               
               <table class="table table-hover table-group-divider" id="t2">
                  <!-- 공지글 시작 -->
                   <c:if test="${countimport > 0}">
                  <c:forEach var="importinfo" items="${informationImportList}">
                  <tr>
                     <td>
                        <div>
                        <c:if test="${importinfo.info_pin == 1}">
                        <span class="blink">
                           <b><span style="color:#ffc400">★</span>
                           <span style="color:#097bd9">필독</span>
                           <span style="color:#ffc400">★</span></b>
                        </span> &nbsp;
                        </c:if>
                        <a href="infoDetail.do?info_num=${importinfo.info_num}" class="truncate-text">${importinfo.info_title}</a>                           
                        </div>                        
                        <span class="t-sub-info">${importinfo.info_date}</span>
                     </td>       
                  </tr>
                  </c:forEach>         
                  </c:if>
                  <!-- 공지글 끝 -->
                  <!-- 일반글(필독제외 시작) -->               
                  <c:forEach var="info" items="${informationList}">
                  <tr>
                     <td>
                        <div>
                        <c:if test="${info.info_pin == 1}">
                        <span class="blink">
                           <b><span style="color:#ffc400">★</span>
                           <span style="color:#097bd9">필독</span>
                           <span style="color:#ffc400">★</span></b>
                        </span> &nbsp;
                        </c:if>
                        <a href="infoDetail.do?info_num=${info.info_num}" class="truncate-text">${info.info_title}</a>                           
                        </div>                        
                        <span class="t-sub-info">${info.info_date}</span>
                     </td>    
                  </tr>
                  </c:forEach>
                  <!-- 일반글(필독제외 끝) -->   
               </table>                     
            </c:if>
            </div><!-- table 끝 -->
            
            <!-- 페이지 번호 시작 -->
            <c:if test="${count>0}">
            <div class="align-center">${page}</div>
            </c:if>
         </div><!-- 사이드바 오른쪽 화면 끝 -->   
      </div><!-- 컨텐트 메인 끝 -->
   </div><!-- 페이지 메인 끝 -->
</body>