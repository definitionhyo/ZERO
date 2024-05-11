package com.itwillbs.zero.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface LikesMapper {

	int addLike(@Param("member_id") String memberId, @Param("secondhand_idx") int secondhandIdx);

    int cancelLike(@Param("member_id") String memberId, @Param("secondhand_idx") int secondhandIdx);

    int getLikeStatus(@Param("member_id") String memberId, @Param("secondhand_idx") int secondhandIdx);

}
