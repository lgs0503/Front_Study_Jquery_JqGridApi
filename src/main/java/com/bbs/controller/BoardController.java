package com.bbs.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bbs.common.CommonUtil;
import com.bbs.service.BoardService;
import com.bbs.vo.BoardGridSearchVO;
import com.bbs.vo.BoardGridVO;
import com.bbs.vo.BoardVO;

@Controller
@RequestMapping("board/")
public class BoardController {

	private static final Logger LOG = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	BoardService service;

	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String BoardView() 
	{	
		LOG.info("[GET] BoardView");
		return "borad";
	}
	
	@RequestMapping(value = "getBoardList", method = RequestMethod.POST)
	public @ResponseBody BoardGridVO getBoardList(@RequestBody BoardGridSearchVO boardGridSearchVO) 
	{	
		LOG.info("[POST] getBoardList");
		
		BoardGridVO boardGridVO = new BoardGridVO();

		try {
			boardGridVO = service.getBoardList(boardGridSearchVO);
		} catch (Exception e) {
			// TODO: handle exception
			LOG.error("[Board] getBoardList : " + e.getMessage(), e);
		}

		return boardGridVO;
	}

	@RequestMapping(value = "deleteBoard", method = RequestMethod.POST)
	public @ResponseBody int deleteBoard(@RequestBody List<BoardVO> boardList) 
	{	
		LOG.info("[POST] deleteBoard");
		
		try {
			service.deleteBoard(boardList);
			return CommonUtil.REQUEST_SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
			LOG.error("[Board] deleteBoard : " + e.getMessage(), e);
			return CommonUtil.REQUEST_ERROR;
		}
	}
	
}