package com.goodee.groupware;

import java.io.IOException;
import java.net.http.HttpRequest;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;

import org.springframework.core.annotation.Order;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebFilter("/*")
@Order(2)
public class SessionUpdateFilter extends HttpFilter implements Filter {
       
    public SessionUpdateFilter() {
        super();
    }

	public void destroy() {
	}
	
//	페이지 이동할때마다 세션 초기화해서 로그인 유지 시간 초기화 
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		log.debug("세션초기화" + request.getServletContext().getSessionTimeout());
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
