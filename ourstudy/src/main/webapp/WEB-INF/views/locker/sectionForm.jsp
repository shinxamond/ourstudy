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
<div id="sectionA"><input type="button" class="section" value="A" onclick="location.href='${pageContext.request.contextPath}/locker/sectionDetail.do?section=A'"></div>
<div id="sectionB"><input type="button"  class="section" value="B" onclick="location.href='${pageContext.request.contextPath}/locker/sectionDetail.do?section=B'"></div>
<div id="sectionC"><input type="button"  class="section" value="C" onclick="location.href='${pageContext.request.contextPath}/locker/sectionDetail.do?section=C'"></div>
<div id="sectionD"><input type="button"  class="section" value="D" onclick="location.href='${pageContext.request.contextPath}/locker/sectionDetail.do?section=D'"></div>

<div class="clear-box" style="clear:both;"></div>
<span id="rent" class="guide-letter">RENT</span><br>
<span id="info" class="guide-letter">INFO</span><br>
</div>	