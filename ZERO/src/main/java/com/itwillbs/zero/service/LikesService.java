package com.itwillbs.zero.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.zero.mapper.LikesMapper;

@Service
public class LikesService {
	
	@Autowired
	private LikesMapper likesMapper;

	public int addLike(String memberId, int secondhandIdx) {
        return likesMapper.addLike(memberId, secondhandIdx);
    }

    public int cancelLike(String memberId, int secondhandIdx) {
        return likesMapper.cancelLike(memberId, secondhandIdx);
    }

    public int getLikeStatus(String memberId, int secondhandIdx) {
        return likesMapper.getLikeStatus(memberId, secondhandIdx);
    }

}
