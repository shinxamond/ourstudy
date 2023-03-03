<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/locker.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/locker_frame.js"></script>
<div id="canvas_box">
<canvas id="canvas"></canvas>  
</div>
<div id="section_box">
<div id="sectionA"><input type="button" class="section" value="A" onclick=""></div>
<div id="sectionB"><input type="button"  class="section" value="B" onclick=""></div>
<div id="sectionC"><input type="button"  class="section" value="C" onclick=""></div>
<div id="sectionD"><input type="button"  class="section" value="D" onclick=""></div>

<div class="clear-box" style="clear:both;"></div>
<button id="sample">Sample</button>
<span id="rent" class="guide-letter">RENT</span><br>
<span id="info" class="guide-letter">INFO</span><br>
</div>	
<table border="1" style="text-align:center; padding:5px;">
<tr>
<c:forEach var="locker" items="${list}" step="3" begin="0" end="${fn:length(list)-1}">
	<td><a href="${pageContext.request.contextPath}/locker/select.do?locker_num=${locker.locker_num}">${locker.locker_num}번</a></td>>
</c:forEach>
</tr>
<tr>
<c:forEach var="locker" items="${list}" step="3" begin="1" end="${fn:length(list)-1}">
	<td><a href="${pageContext.request.contextPath}/locker/select.do?locker_num=${locker.locker_num}">${locker.locker_num}번</a></td>
</c:forEach>
</tr>
<tr>
<c:forEach var="locker" items="${list}" step="3" begin="2" end="${fn:length(list)-1}">
	<td><a href="${pageContext.request.contextPath}/locker/select.do?locker_num=${locker.locker_num}">${locker.locker_num}번</a></td>
</c:forEach>
</tr>
</table>