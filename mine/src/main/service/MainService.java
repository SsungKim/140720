package main.service;

import java.util.*;

import javax.servlet.http.*;

import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

@Component
public class MainService {
	@Autowired
	SqlSessionFactory fac;
	
	// login
	public boolean login(String id, String pw, HttpSession session){
		SqlSession ss = fac.openSession();
		HashMap<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("pw", pw);
		List<HashMap> list = ss.selectList("member.login", map);
		ss.close();
		if(list.size()>0){
			session.setAttribute("login", list.get(0));
			return true;
		} else {
			return false;
		}
	}
	
	// login_program
	public HashMap login_p(String id, String pw){
		SqlSession ss = fac.openSession();
		HashMap<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("pw", pw);
		List<HashMap> list = ss.selectList("member.login", map);
		ss.close();
		if(list.size()>0){
			return list.get(0);
		} else {
			return null;
		}
	}
	
	// logout
	public void logout(HttpSession session) {
		session.removeAttribute("login");
	}
}
