package com.bbs.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bbs.service.BoardService;
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
		// 호출 시 찍히게 될 로그
		LOG.info("[GET] BoardView");
		return "borad";
	}
	
	@RequestMapping(value = "getBoardList", method = RequestMethod.GET)
	public @ResponseBody List<BoardVO> getBoardList() 
	{	
		// 호출 시 찍히게 될 로그
		LOG.info("[GET] getBoardList");
		// 결과 값을 담을 ResultVO를 선언한 생성자를 통해서 만드는데 기본값은 success는 false, result는 null로 세팅
		List<BoardVO> result = new ArrayList<BoardVO>();

		try {
			result = service.getBoardList();
		} catch (Exception e) {
			// TODO: handle exception
			LOG.error("[Board] getBoardList : " + e.getMessage(), e);
		}

		return result;

	}
}