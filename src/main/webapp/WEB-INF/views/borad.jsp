<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<c:import url="/WEB-INF/views/com/import.jsp"></c:import>
<head>
	<title>게시판</title>
</head>
<body>
	<div class="content">
		<div class="search-form">
			<div class="search-ipt">
				<label>조건</label>
				<select id="combo-search">
					<option value="all">전체</option>
					<option value="title">제목</option>
					<option value="writer">작성자</option>
				</select>
				<input type="text" id="keyword" placeholder="조회조건 입력">
			</div>
			<div class="search-btn">
				<input id="btn-search" type="button" value="조회하기">
			</div>
		</div>
		<div class="btn-from">
			<input type="button" id="btn-add" value="추가하기">
			<input type="button" id="btn-delete"value="삭제하기">
		</div>
		<div>
			<table id="jsonmap"></table>
			<div id="pjmap"></div>
		</div>
	</div>
</body>

<script>

/* 화면 로드 */
$(document).ready(function(){
	createGrid();
	
	$("#btn-search").click(function(){
		 $("#jsonmap").trigger("reloadGrid");
	});
	
	$("#btn-add").click(function(){
		
	});
	

	$("#btn-delete").click(function(){
		
	});
});

function createGrid(){

	/* List 로드*/
	$("#jsonmap").jqGrid({        
	   	url:'<c:url value="/board/getBoardList"/>',
	   	datatype: "json",
	   	mtype: "POST",
	   	ajaxGridOptions: { contentType: "application/json;charset=utf-8" },
	   	colNames:['No', '제목', '내용', '작성자', '등록일'],
	   	colModel:[
	   		{name:'bno'		,index:'bno'	, width:55	, align:"center" , hidden:false},
	   		{name:'title'	,index:'title'	, width:90	, align:"center" , hidden:false},
	   		{name:'content'	,index:'content', width:100 , align:"center" , hidden:false},
	   		{name:'writer'	,index:'writer'	, width:80	, align:"center" , hidden:false},
	   		{name:'regDate'	,index:'regDate', width:80	, align:"center" , hidden:false}	
	   	],
	   	rowNum : 3,
	   	rowList : [3,10,20],
	   	pager: '#pjmap',
	    viewrecords :  true,
	    sortorder :  "asc",
	    sortname : "bno",
		caption : "JQGrid 게시판",
		autowidth : true,
		jsonReader : { 
			root		: "boardList", 
			page		: "page", 
			total		: "totalCount",
		    records		: "records",
			repeatitems	: false,
		},
		serializeGridData: function (postData) {
			console.log($("#combo-search").val());
			console.log($("#keyword").val());
			
			var searchVO = new Object();
			searchVO.searchKey = $("#combo-search").val();
			searchVO.keyword = $("#keyword").val();
			
			$.extend(postData, searchVO);
			
			console.log(JSON.stringify(postData));
	    	return JSON.stringify(postData);
	    },
		loadComplete:function(data){
			console.log(JSON.stringify(data));
		},
		loadError:function(xhr,status,error){
			console.log("게시판 조회에 실패 하였습니다.");
		},
		onCellSelect:function(rowid, index, contents, event){
			var cm = $(this).jqGrid('getGridParam', 'colModel');
			console.log(cm);
			
			if (cm[index].name=='title'){
				alert($(this).jqGrid('getCell', rowid, 'title')); 
       	 	}
		}
	});
	
	$("#jsonmap").jqGrid('navGrid', '#pjmap', {edit : true,
							                   add  : true,
							                   del  : true});
}
</script>