package com.goodee.groupware.sevice;


import java.io.File;
import java.io.FileOutputStream;

import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodee.groupware.mapper.MemberMapper;
import com.goodee.groupware.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberService {
	@Autowired
	private MemberMapper memberMapper;
	
	public Member checkMember(Member member) {
		return memberMapper.checkMember(member);
	}
	
	public int updatePw(Member member) {
		return memberMapper.updatePw(member);
	}
	
	public int updateOneMember(Member member) {
		return memberMapper.updateOneMember(member);
	}
	
	public int updateSign(String memberId, String sign, String path) {
		String type = ".png";
		String data = sign.split(",")[1];
		byte[] image = Base64.decodeBase64(data);
		String memberSignFile = memberId + type;
		log.debug("memberService updateSign" + memberSignFile);
		int row = 0;
		Member member = new Member();
		member.setMemberId(memberId);
		member.setMemberSignFile(memberSignFile);
		
		File f = new File(path + memberSignFile);
		
		try {
			FileOutputStream fileOutputStream = new FileOutputStream(f);
			fileOutputStream.write(image);
			fileOutputStream.close();
			row = memberMapper.updateSign(member);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		}
		return row;
	}
}
