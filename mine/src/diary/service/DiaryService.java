package diary.service;

import java.text.*;
import java.util.*;

import javax.servlet.http.*;

import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

@Component
public class DiaryService {
	@Autowired
	SqlSessionFactory fac;
	
	// diary List
	public List<HashMap> diary(String year, String month){
		SqlSession ss = fac.openSession();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		String today = sdf.format(System.currentTimeMillis());
		List<HashMap> list = ss.selectList("diary.diary");
		ss.close();
		List<HashMap> list2 = new Vector<>();
		if(year == null && month == null){
			for(HashMap m : list){
				String day = m.get("day").toString().substring(0, 7);
				if(day.equals(today)){
					list2.add(m);
				}
			}
		} else {
			for(HashMap m : list){
				String mYear = m.get("day").toString().substring(0, 4);
				String mMonth = m.get("day").toString().substring(5, 7);
				if(mYear.equals(year) && mMonth.equals(0+month)){
					list2.add(m);
				}
			}
		}
		return list2;
	}

	// save
	public boolean save(String title, String content, String folder, HttpSession session) {
		SqlSession ss = fac.openSession();
		HashMap<String, String> map = new HashMap<>();
		String id = ((HashMap)session.getAttribute("login")).get("id").toString();
		String nick = ((HashMap)session.getAttribute("login")).get("nick").toString();
		map.put("title", title);
		map.put("content", content);
		map.put("id", id);
		map.put("nick", nick);
		map.put("folder", folder);
		try{
			ss.insert("diary.write", map);
			ss.commit();
			ss.close();
			return true;
		} catch(Exception e){
			e.printStackTrace();
			ss.rollback();
			ss.close();
			return false;
		}
	}

	// search
	public List<HashMap> search(String folder, String year, String month) {
		SqlSession ss = fac.openSession();
		List<HashMap> list = ss.selectList("diary.search", folder);
		ss.close();
		List<HashMap> searchList = new Vector<>();
		for(HashMap m : list){
			String mYear = m.get("day").toString().substring(0, 4);
			String mMonth = m.get("day").toString().substring(5, 7);
			if(mYear.equals(year) && mMonth.equals(0+month)){
				searchList.add(m);
			}
		}
		return searchList;
	}

	// view
	public HashMap<String, String> view(String num) {
		SqlSession ss = fac.openSession();
		HashMap<String, String> map = ss.selectOne("diary.view", num);
		ss.close();
		return map;
	}

	// reply
	public boolean reply(String num, String reply, HttpSession session) {
		SqlSession ss = fac.openSession();
		HashMap<String, String> map = new HashMap<>();
		map.put("num", num);
		map.put("reply", reply);
		map.put("id", ((HashMap)session.getAttribute("login")).get("id").toString());
		map.put("nick", ((HashMap)session.getAttribute("login")).get("nick").toString());
		try{
			ss.insert("diary.reply", map);
			ss.commit();
			ss.close();
			return true;
		} catch(Exception e){
			e.printStackTrace();
			ss.rollback();
			ss.close();
			return false;
		}
	}

	// reply List
	public List<HashMap> replyList(String num) {
		SqlSession ss = fac.openSession();
		List<HashMap> list = ss.selectList("diary.replyList", num);
		ss.close();
		return list;
	}

	// modify
	public boolean modify(String num, String title, String content) {
		SqlSession ss = fac.openSession();
		HashMap<String, String> map = new HashMap<>();
		map.put("num", num);
		map.put("title", title);
		map.put("content", content);
		int n = ss.update("diary.modify", map);
		if(n>0){
			ss.commit();
			ss.close();
			return true;
		} else {
			ss.rollback();
			ss.close();
			return false;
		}
	}

	// remove
	public boolean remove(String num) {
		SqlSession ss = fac.openSession();
		int n = ss.delete("diary.remove", num);
		if(n>0){
			ss.commit();
			ss.close();
			return true;
		} else {
			ss.rollback();
			ss.close();
			return false;
		}
	}
}
