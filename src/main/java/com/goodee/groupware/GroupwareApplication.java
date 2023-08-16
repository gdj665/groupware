package com.goodee.groupware;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication

// filter 읽기위해 선언하는 어노테이션
@ServletComponentScan
public class GroupwareApplication {

	public static void main(String[] args) {
		SpringApplication.run(GroupwareApplication.class, args);
	}

}
