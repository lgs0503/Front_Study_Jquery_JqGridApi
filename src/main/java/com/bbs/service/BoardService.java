package com.bbs.service;


import com.bbs.vo.BoardGridSearchVO;
import com.bbs.vo.BoardGridVO;

public interface BoardService {
	
	public BoardGridVO getBoardList(BoardGridSearchVO boardGridSearchVO);
	
	public int getBoardListCount();

}