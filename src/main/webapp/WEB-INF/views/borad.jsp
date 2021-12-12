<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<c:import url="/WEB-INF/views/com/import.jsp"></c:import>
<head>
	<title>게시판</title>
</head>
<body>
	<div>
		<table id="jsonmap"></table>
		<div id="pjmap"></div>
	</div>
</body>

<script>

/* 화면 로드 */
$(document).ready(function(){
	
	/* List 로드*/
	$("#jsonmap").jqGrid({        
	   	url:'<c:url value="/board/getBoardList"/>',
	    mtype : "post",
		datatype: "json",
	   	colNames:['No', '제목', '내용', '작성자', '등록일'],
	   	colModel:[
	   		{name:'bno'		,index:'bno'	, width:55	, align:"center"},
	   		{name:'title'	,index:'title'	, width:90	, align:"center"},
	   		{name:'content'	,index:'content', width:100 , align:"center"},
	   		{name:'writer'	,index:'writer'	, width:80	, align:"center"},
	   		{name:'regDate'	,index:'regDate', width:80	, align:"center"}	
	   	],
	   	rowNum:3,
	   	rowList:[3,10,20],
	   	pager: '#pjmap',
	    viewrecords: true,
	    sortorder: "desc",
		caption: "게시판",
		width: "1000px"
	});
	
	$("#jsonmap").jqGrid('navGrid','#pjmap',{edit:false,add:false,del:false});
});
</script>