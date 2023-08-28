package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AddressMapper {
	List<Map<String,Object>> getAddressList(Map<String,Object> addressMap);
	int getAddressListCnt(Map<String,Object> addressMap);
}
