package com.goodee.groupware.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.groupware.sevice.AddressService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AddressController {
	@Autowired
	private AddressService addressService;
	
	// 1) 주소록 리스트
	@GetMapping("/address/addressList")
	public String getAddressList(Model model,
								@RequestParam(name ="currentPage", defaultValue = "1") int currentPage,
								@RequestParam(name ="rowPerPage", defaultValue = "10") int rowPerPage,
								@RequestParam(name ="searchName", required = false) String searchName,
								@RequestParam(name ="colpol", required = false) String colpol){
		log.debug("AddressController.getAddressList() 요청값 디버깅 --->" + currentPage, rowPerPage, searchName, colpol);
		log.debug("AddressController.getAddressList() 요청값 디버깅 colpol--->" +  colpol);
		//  주소록 리스트 서비스 호출
		Map<String, Object> getAddressList = addressService.getAddressList(currentPage, rowPerPage, searchName, colpol);
		
		model.addAttribute("getAddressList", getAddressList.get("getAddressList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", getAddressList.get("lastPage"));
		return "/address/addressList";
	}
}
