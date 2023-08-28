package com.goodee.groupware.restapi;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.io.BufferedReader;
import java.io.IOException;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HolidayRest {
	    @ResponseBody 
	    @GetMapping("/rest/holidayList")
	    public String getHolidayList(String targetYear, String targetMonth) throws IOException{
	    	StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo"); /*URL*/
	    	urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "="+ "tFL7GJrOcvvUeZMI0YoBejWUp9kDhMLlOj2HBxVDYOC%2FHjewkU%2BRXTxk4O5%2FiEFpSEqYPW1nT2j9IGDNoGMc9A%3D%3D"); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*타입*/
	        urlBuilder.append("&" + URLEncoder.encode("solYear","UTF-8") + "=" + URLEncoder.encode(targetYear, "UTF-8")); /*검색할 연도*/
	        
	        // targetMonth가 10보다 작으면 앞에 0을 붙여서 검색할 달을 만든다.
	        // ex) 8월달이면 값을 08을 넣어야 된다.
	        int intTargetMonth = Integer.parseInt(targetMonth);
	        String formattedMonth = intTargetMonth < 10 ? "0" + intTargetMonth : String.valueOf(intTargetMonth);
	        urlBuilder.append("&" + URLEncoder.encode("solMonth", "UTF-8") + "=" + URLEncoder.encode(formattedMonth, "UTF-8"));
	        // urlBuilder.append("&" + URLEncoder.encode("solMonth","UTF-8") + "=" + URLEncoder.encode("0"+targetMonth, "UTF-8")); /*검색할 달*/
	        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("365", "UTF-8")); /*최대로 출력할 공휴일 수*/
	        
	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        
	        BufferedReader rd;
	    	if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) { //http status code check
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
	        }
	    	
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        rd.close();
	        conn.disconnect();
	        // System.out.println(sb.toString());
	        
	        return sb.toString();
	    }
}