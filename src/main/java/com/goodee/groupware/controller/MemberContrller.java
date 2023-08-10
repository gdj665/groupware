package com.goodee.groupware.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberContrller {
	@GetMapping("/login")
	public void login() {
	}
}
