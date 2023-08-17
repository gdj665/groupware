package com.goodee.groupware.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.Member;
@Mapper
public interface HrmMapper {

	Member getOneMember(String memberId);
}
