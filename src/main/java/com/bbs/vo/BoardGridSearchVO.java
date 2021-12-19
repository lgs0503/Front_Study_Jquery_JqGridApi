package com.bbs.vo;

import lombok.Data;

@Data
public class BoardGridSearchVO {

	boolean _search;
	String nd;
	int rows;
	int page;
	String sord;
	String sidx;
	
	int startRow;
	int endRow;
	
	String searchKey;
	String keyword;
}
