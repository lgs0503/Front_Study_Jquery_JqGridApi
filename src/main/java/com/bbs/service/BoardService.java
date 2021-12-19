package com.bbs.service;


import java.util.List;

import com.bbs.vo.BoardGridSearchVO;
import com.bbs.vo.BoardGridVO;
import com.bbs.vo.BoardVO;

public interface BoardService {
	
	public BoardGridVO getBoardList(BoardGridSearchVO boardGridSearchVO);
	
	public int getBoardListCount(BoardGridSearchVO boardGridSearchVO);

	public int deleteBoard(List<BoardVO> boardList);
	
}