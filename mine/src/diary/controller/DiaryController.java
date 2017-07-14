package diary.controller;

import java.util.*;

import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import diary.service.*;

@Controller
@RequestMapping("/diary")
public class DiaryController {
	@Autowired
	DiaryService ds;

	// diary
	@RequestMapping("")
	public ModelAndView diary(){
		ModelAndView mav = new ModelAndView("t:diary/diary");
		List<HashMap> list = ds.diary(null, null);
		mav.addObject("list", list);
		if(list.size()>0){
			mav.addObject("diary", list.get(0));
			List<HashMap> reply = ds.replyList(list.get(0).get("auto").toString());
			mav.addObject("reply", reply);
		}
		return mav;
	}
	
	// write
	@RequestMapping("/write")
	public ModelAndView write(){
		ModelAndView mav = new ModelAndView("t:diary/write");
		List<HashMap> list = ds.diary(null, null);
		mav.addObject("list", list);
		return mav;
	}
	
	// save
	@RequestMapping("/save")
	public ModelAndView save(@RequestParam(name="title")String title, @RequestParam(name="content")String content, 
											@RequestParam(name="folder")String folder, HttpSession session){
		ModelAndView mav = new ModelAndView("t:diary/diary");
		boolean b = ds.save(title, content, folder, session);
		mav.addObject("save", b);
		return mav;
	}
	
	// search
	@RequestMapping("/search/{folder}/{year}/{month}")
	@ResponseBody
	public ModelAndView search(@PathVariable(name="folder")String folder, @PathVariable(name="year")String year,
												@PathVariable(name="month")String month){
		ModelAndView mav = new ModelAndView("/diary/listAjax.jsp");
		List<HashMap> list = new Vector<>();
		if(folder.equals("ÀüÃ¼")){
			list = ds.diary(year, month);
		} else {
			list = ds.search(folder, year, month);
		}
		mav.addObject("list", list);
		return mav;
	}
	
	// view
	@RequestMapping("/view/{num}")
	@ResponseBody
	public ModelAndView view(@PathVariable(name="num")String num){
		ModelAndView mav = new ModelAndView("/diary/contentAjax.jsp");
		HashMap<String, String> diary = ds.view(num);
		mav.addObject("diary", diary);
		List<HashMap> reply = ds.replyList(num);
		mav.addObject("reply", reply);
		return mav;
	}
	
	// reply
	@RequestMapping("/reply/{num}/{reply}")	
	@ResponseBody
	public boolean reply(@PathVariable(name="num")String num, @PathVariable(name="reply")String reply, HttpSession session){
		return ds.reply(num, reply, session);
	}
	
	// modify
	@RequestMapping("/modify/{num}")
	public ModelAndView modify(@PathVariable(name="num")String num){
		ModelAndView mav = new ModelAndView("t:diary/modify");
		List<HashMap> list = ds.diary(null, null);
		mav.addObject("list", list);
		HashMap<String, String> diary = ds.view(num);
		mav.addObject("diary", diary);
		return mav;
	}
	
	// modify save
	@RequestMapping("/modifySave")
	public ModelAndView modifySave(@RequestParam(name="num")String num, @RequestParam(name="title")String title, 
														@RequestParam(name="content")String content){
		ModelAndView mav = new ModelAndView("t:diary/diary");
		List<HashMap> list = ds.diary(null, null);
		mav.addObject("list", list);
		HashMap<String, String> diary = ds.view(num);
		mav.addObject("diary", diary);
		boolean b = ds.modify(num, title, content);
		mav.addObject("modify", b);
		return mav;
	}
	
	// remove
	@RequestMapping("/remove/{num}")
	@ResponseBody
	public boolean remove(@PathVariable(name="num")String num){
		return ds.remove(num);
	}
}
