package com.bbs.vo;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class BoardGridVO {

	List<BoardVO> boardList = new ArrayList<BoardVO>();

	int totalCount;
	int page;
	int records;
	
}
