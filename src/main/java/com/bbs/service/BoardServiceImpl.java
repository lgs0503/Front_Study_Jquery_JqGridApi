package com.bbs.service;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bbs.common.CommonUtil;
import com.bbs.mapper.BoardMapper;
import com.bbs.vo.BoardGridSearchVO;
import com.bbs.vo.BoardGridVO;
import com.bbs.vo.BoardVO;

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
			boardGridVO.setTotalCount(mapper.getBoardCount(boardGridSearchVO));
			boardGridVO.setRecords(boardGridSearchVO.getRows());
			boardGridVO.setPage(boardGridSearchVO.getPage());
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return boardGridVO;
	}

	@Override
	public int getBoardListCount(BoardGridSearchVO boardGridSearchVO) {
		
		int count = 0;
		
		try (SqlSession session = sqlSessionFactory.openSession()) {
			BoardMapper mapper = session.getMapper(BoardMapper.class);

			count = mapper.getBoardCount(boardGridSearchVO);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return count;
	}
	
	@Override
	public int saveBoard(BoardVO boardVO) {

		try (SqlSession session = sqlSessionFactory.openSession()) {
			BoardMapper mapper = session.getMapper(BoardMapper.class);

			int status = boardVO.getBno();
			
			if(status == 0) {
				mapper.insertBoard(boardVO);
			} else {
				mapper.updateBoard(boardVO);
			}
			
			return CommonUtil.REQUEST_SUCCESS;
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return CommonUtil.REQUEST_ERROR;
		}
	}

	@Override
	public int deleteBoard(List<BoardVO> boardList) {
		
		try (SqlSession session = sqlSessionFactory.openSession()) {
			BoardMapper mapper = session.getMapper(BoardMapper.class);

			for(BoardVO vo : boardList) {
				mapper.deleteBoard(vo);
			}
			return CommonUtil.REQUEST_SUCCESS;
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return CommonUtil.REQUEST_ERROR;
		}
	}


}