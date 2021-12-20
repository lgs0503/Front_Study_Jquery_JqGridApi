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
				<label class="search-label">조건</label>
				<select id="combo-search" class="search-select">
					<option value="all">전체</option>
					<option value="title">제목</option>
					<option value="writer">작성자</option>
				</select>
				<input class="ipt-text" type="text" id="keyword" placeholder="조회조건 입력">
			</div>
			<div class="search-btn">
				<input class="ipt-btn" id="btn-search" type="button" value="조회하기">
			</div>
		</div>
		<div class="btn-from">
			<input class="ipt-btn" type="button" id="btn-add" value="추가하기">
			<input class="ipt-btn" type="button" id="btn-delete"value="삭제하기">
		</div>
		<div>
			<table id="jsonmap"></table>
			<div id="pjmap"></div>
		</div>
	</div>
	
	<div class="grid-detail" id="dialog">
	
		<div style="display: none">
			<label>No</label>
			<input type="text" id="bno"/>
		</div>
		<div>
			<label>제목</label>
			<input type="text" id="title"/>
		</div>
		<div>
			<label>내용</label>
			<textarea rows="" cols=""  id="content"></textarea>
		</div>
		<div>
			<label>작성자</label>
			<input type="text" id="writer"/>
		</div>
		<div>
			<label>등록일</label>
			<input type="text" id="regDate"/>
		</div>
		<div>
			<input type="button" value="저장" id="popup-btn-save" />
			<input type="button" value="취소" id="popup-btn-close"/>
		</div>
	</div>
</body>

<script>
var arrayModel = ['bno','title','content','writer','regDate'];

/* 화면 로드 */
$(document).ready(function(){
	
	createGrid();
	
	$("#regDate").datepicker({ dateFormat: 'yy-mm-dd' });
	
	$("#btn-search").click(function(){
		 $("#jsonmap").trigger("reloadGrid");
	});
	
	$("#btn-add").click(function(){
		openDialog('신규');
		
		for(var i in arrayModel){
			if(i == 0){
				$("#"+arrayModel[0]).val("0");
				continue;
			}
			
			console.log(arrayModel[i]);
			$("#"+arrayModel[i]).val('');
		}
	});
	
	/* 삭제  */
	$("#btn-delete").click(function(){
	    if(confirm("삭제하시겟습니까?")){

		    var arrayChk = $("#jsonmap").jqGrid('getGridParam', 'selarrrow');

		    var array = [];
		    var len = arrayChk.length;
		    
		    if(len == 0){
		    	alert("선택된 데이터가 없습니다.");
		    	return;
		    }
			
		    for(var i = 0; i < len; i++){
		        var rowObject = $("#jsonmap").getRowData(arrayChk[i]);      //체크된 id의 row 데이터 정보를 Object 형태로 반환
		        var value = rowObject.bno;     //Obejct key값이 name인 value값 반환
		        console.log("삭제데이터:"+value);

		        array.push(rowObject);
		    }  
		    
		    $.ajax({
		    	url : '<c:url value="/board/deleteBoard"/>',
		    	datatype : "json",
		    	type : "post",
	            contentType: 'application/json; charset=utf-8',
		    	data : JSON.stringify(array),
	            success:function(data){
	            	console.log("성공");
	       		 	$("#jsonmap").trigger("reloadGrid");
	            },
	            error:function(request, status, error){
	                console.log("AJAX_ERROR");
	            }
		    }); 
		}
	});
	

	  $("#popup-btn-save").click(function(){
		  if(confirm("저장하시겠습니까")){
	 		  var object = {bno 	: $("#bno").val(),
	 				        title 	: $("#title").val(),
	 				        content : $("#content").val(),
	 				        writer	: $("#writer").val(),
	 				        regDate : $("#regDate").val()};
		  
	 		  $.ajax({
		    	url : '<c:url value="/board/saveBoard"/>',
		    	datatype : "json",
		    	type : "post",
	            contentType: 'application/json; charset=utf-8',
		    	data : JSON.stringify(object),
	            success:function(data){
	            	$('#dialog').dialog('close');
	            	alert("저장 되었습니다.");
	            	console.log("성공");
	       		 	$("#jsonmap").trigger("reloadGrid");
	            },
	            error:function(request, status, error){
	                console.log("AJAX_ERROR");
	            }
	 		  });
		  }
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
	   	rowNum : 10,
	   	rowList : [10,20,30],
	   	pager: '#pjmap',
	    viewrecords :  true,
	    sortorder :  "asc",
	    sortname : "bno",
		caption : "JQGrid 게시판",
		autowidth : true,
        multiselect:true, 
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
			
			if (cm[index].name=='title'){
				
				openDialog('상세정보');
				
				for(var i in arrayModel){
					console.log(arrayModel[i]);
					$("#"+arrayModel[i]).val($(this).jqGrid('getCell', rowid, arrayModel[i]));
				}
       	 	}
		},
		beforeSelectRow: function (rowid, e) {
        	i = $.jgrid.getCellIndex($(e.target).closest('td')[0]),
        	cm = $(this).jqGrid('getGridParam', 'colModel');
    		return (cm[i].name === 'cb');
		}
	});
	
	$("#jsonmap").jqGrid('navGrid', '#pjmap', {edit : false,
							                   add  : false,
							                   del  : false});
}

function openDialog(title){
	
	$('#dialog').dialog({
	      title: title,
	      modal: true,
	      width: '500',
	      height: '600',
	      closeOnEscape: false, 
	      open: function(event, ui) { 
	    	  
	    	  $("#popup-btn-close").click(function(){
	    		  $('#dialog').dialog('close');
	    	  });
	    	  
	    	  $(".ui-dialog-titlebar-close").hide(); 
	      }
	});
}
</script>