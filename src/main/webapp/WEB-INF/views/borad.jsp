<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
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
				<input v-on:click="searchBorad" class="ipt-btn" id="btn-search" type="button" value="조회하기">
			</div>
		</div>
		<div class="btn-from">
			<input v-on:click="addBorad" class="ipt-btn" type="button" id="btn-add" value="추가하기">
			<input v-on:click="deleteBorad" class="ipt-btn" type="button" id="btn-delete"value="삭제하기">
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