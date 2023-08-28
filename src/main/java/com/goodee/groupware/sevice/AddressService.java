package com.goodee.groupware.sevice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.groupware.mapper.AddressMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class AddressService {
	@Autowired
	private AddressMapper addressMapper;
	
	// 1) 주소록 리스트
	public Map<String, Object> getAddressList(int currentPage, int rowPerPage, String searchName, String colpol){
		//페이징 작업 
		int beginRow = (currentPage -1) * rowPerPage;
		
		// 페이징 && 검색을 위한 변수를 맵에 담아 사용한다.
		Map<String,Object> pageMap = new HashMap<>();
		pageMap.put("beginRow", beginRow);
		pageMap.put("rowPerPage", rowPerPage);
		pageMap.put("searchName", searchName);
		pageMap.put("colpol", colpol);
		
		// 장비리스트메서드 호출 페이징을 위해 만든 pageMap을 매개변수로 한다.
		List<Map<String,Object>> getAddressList = addressMapper.getAddressList(pageMap);
		log.debug("AddressService.getAddressList() getAddressList --->" + getAddressList.toString());
		
		// 장비리스트에 전체행의 개수를 구하는 메서드 호출
		int addressListCount = addressMapper.getAddressListCnt(pageMap);
		log.debug("AddressService.getAddressList() addressListCount --->" + addressListCount);
		
		// 마지막 페이지 구하기
		int lastPage = addressListCount / rowPerPage;
		if(addressListCount % rowPerPage != 0) {
			lastPage += 1;
		}
		// 결과값을 반환하는 resultMap
		Map<String, Object> resultMap = new HashMap<>();
		
		resultMap.put("getAddressList", getAddressList);
		resultMap.put("lastPage", lastPage);	
		return resultMap;
	}
	
	
}
