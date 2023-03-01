<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/locker.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/locker_frame.js"></script>
<div id="canvas_box">
<canvas id="canvas"></canvas>  
</div>
<div id="sectionA"><input type="button"  class="section" value="A" onclick=""></div>
<div id="sectionB"><input type="button"  class="section" value="B" onclick=""></div>
<div id="sectionC"><input type="button"  class="section" value="C" onclick=""></div>
<div id="sectionD"><input type="button"  class="section" value="D" onclick=""></div>


<span id="rent" class="guide-letter">RENT</span><br>
<span id="info" class="guide-letter">INFO</span><br>
	
	
<c:forEach var="locker" items="${list}">
	<p><a href="${pageContext.request.contextPath}/locker/select.do?locker_num=${locker.locker_num}">${locker.locker_num}</a></p>
</c:forEach>

