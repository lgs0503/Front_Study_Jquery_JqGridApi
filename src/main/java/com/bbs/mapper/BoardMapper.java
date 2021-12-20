package com.bbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bbs.vo.BoardGridSearchVO;
import com.bbs.vo.BoardVO;

@Mapper
public interface BoardMapper {

	public List<BoardVO> getBoardList(BoardGridSearchVO boardGridSearchVO);
	
	public int getBoardCount(BoardGridSearchVO boardGridSearchVO);
	
	public int boardList(BoardGridSearchVO boardGridSearchVO);

	public int insertBoard(BoardVO vo);
	
	public int updateBoard(BoardVO vo);
	
	public int deleteBoard(BoardVO boardVO);
}