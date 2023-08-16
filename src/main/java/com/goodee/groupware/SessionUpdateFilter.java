package com.goodee.groupware;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebFilter("/*")
public class SessionUpdateFilter extends HttpFilter implements Filter {
       
    public SessionUpdateFilter() {
        super();
    }

	public void destroy() {
	}
	
//	페이지 이동할때마다 세션 초기화해서 로그인 유지 시간 초기화 
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
//		request를 다형성 활용해서 HttpServletRequest로 재 선언
		HttpServletRequest httpRequest = (HttpServletRequest)request;
//		httpRequest에 있는 getSession() 메소드를 통해서 HttpSession 선언
		HttpSession session = httpRequest.getSession();
//		로그인 상태일때 세션 초기화 되게 만듬
		if(session.getAttribute("loginMember") != null) {
			session.setAttribute("loginMember", session.getAttribute("loginMember"));
			session.setMaxInactiveInterval(2 * 60 * 60); // 시간 * 분 * 초
			log.debug("세션초기화");
		}
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
