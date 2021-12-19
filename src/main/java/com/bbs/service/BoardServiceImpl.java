package com.bbs.service;


import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bbs.common.CommonUtil;
import com.bbs.mapper.BoardMapper;
import com.bbs.vo.BoardGridSearchVO;
import com.bbs.vo.BoardGridVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private SqlSessionFactory sqlSessionFactory;

	@Override
	public BoardGridVO getBoardList(BoardGridSearchVO boardGridSearchVO) {

		BoardGridVO boardGridVO = new BoardGridVO();
		
		// TODO Auto-generated method stub

		try (SqlSession session = sqlSessionFactory.openSession()) {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			
			boardGridSearchVO = CommonUtil.setPagingData(boardGridSearchVO);
			
			boardGridVO.setBoardList(mapper.getBoardList(boardGridSearchVO));
			boardGridVO.setTotalCount(mapper.getBoardCount() / boardGridSearchVO.getRows());
			boardGridVO.setRecords(boardGridSearchVO.getRows());
			boardGridVO.setPage(boardGridSearchVO.getPage());
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return boardGridVO;
	}

	@Override
	public int getBoardListCount() {
		
		int count = 0;
		
		try (SqlSession session = sqlSessionFactory.openSession()) {
			BoardMapper mapper = session.getMapper(BoardMapper.class);

			count = mapper.getBoardCount();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return count;
	}

}