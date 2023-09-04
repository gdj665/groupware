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
		String startCol = "";
		String endCol = "";
		if(colpol != null) {
			if(colpol.equals("ㄱ")) {
				colpol = colpol+"%";
				startCol = "가";
				endCol = "나";
			} else if(colpol.equals("ㄴ")) {
				colpol = colpol+"%";
				startCol = "나";
				endCol = "다";
			} else if(colpol.equals("ㄷ")) {
				colpol = colpol+"%";
				startCol = "다";
				endCol = "라";
			} else if(colpol.equals("ㄹ")) {
				colpol = colpol+"%";
				startCol = "라";
				endCol = "마";
			} else if(colpol.equals("ㅁ")) {
				colpol = colpol+"%";
				startCol = "마";
				endCol = "바";
			} else if(colpol.equals("ㅂ")) {
				colpol = colpol+"%";
				startCol = "바";
				endCol = "사";
			} else if(colpol.equals("ㅅ")) {
				colpol = colpol+"%";
				startCol = "사";
				endCol = "아";
			} else if(colpol.equals("ㅇ")) {
				colpol = colpol+"%";
				startCol = "아";
				endCol = "자";
			} else if(colpol.equals("ㅈ")) {
				colpol = colpol+"%";
				startCol = "자";
				endCol = "차";
			} else if(colpol.equals("ㅊ")) {
				colpol = colpol+"%";
				startCol = "차";
				endCol = "카";
			} else if(colpol.equals("ㅋ")) {
				colpol = colpol+"%";
				startCol = "카";
				endCol = "타";
			} else if(colpol.equals("ㅌ")) {
				colpol = colpol+"%";
				startCol = "타";
				endCol = "파";
			} else if(colpol.equals("ㅍ")) {
				colpol = colpol+"%";
				startCol = "파";
				endCol = "하";
			} else if(colpol.equals("ㅎ")) {
				colpol = colpol+"%";
				startCol = "하";
				endCol = null;
			} else {
				colpol = null;
				startCol = null;
				endCol = null;
			}
		}
		if("".equals(searchName)) {
			searchName = null;
		}
		
		// 페이징 && 검색을 위한 변수를 맵에 담아 사용한다.
		Map<String,Object> pageMap = new HashMap<>();
		pageMap.put("beginRow", beginRow);
		pageMap.put("rowPerPage", rowPerPage);
		pageMap.put("colpol", colpol); // colpol 파라미터를 Map에 추가
		pageMap.put("searchName", searchName);
		pageMap.put("startCol", startCol);
		pageMap.put("endCol", endCol);
		
		log.debug("AddressService.getAddressList() pageMap --->" + pageMap.toString());
		
		List<Map<String,Object>> getAddressList = addressMapper.getAddressList(pageMap);
		log.debug("AddressService.getAddressList() getAddressList --->" + getAddressList.toString());
		
		int addressListCount = addressMapper.getAddressListCnt(pageMap);
		log.debug("AddressService.getAddressList() addressListCount --->" + addressListCount);
		
		// 마지막 페이지 구하기
		int lastPage = addressListCount / rowPerPage;
		if(addressListCount % rowPerPage != 0) {
			lastPage += 1;
		}
		// 페이지 네비게이션 페이징
		int pagePerPage = 5;
		
		// 마지막 페이지 구하기
		// 최소페이지,최대페이지 구하기
		int minPage = ((currentPage-1) / pagePerPage) * pagePerPage + 1;
		int maxPage = minPage + (pagePerPage -1);
		
		// maxPage가 마지막 페이지를 넘어가지 않도록 함
		if(maxPage > lastPage) {
			maxPage = lastPage;
		}
		// 결과값을 반환하는 resultMap
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("minPage", minPage);
		resultMap.put("maxPage", maxPage);
		resultMap.put("getAddressList", getAddressList);
		resultMap.put("lastPage", lastPage);	
		return resultMap;
	}
}
