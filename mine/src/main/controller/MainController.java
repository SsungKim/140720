package main.controller;

import java.util.*;

import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import main.service.*;

@Controller
@RequestMapping("/")
public class MainController {
	@Autowired
	MainService ms;
	
	// index
	@RequestMapping("")
	public ModelAndView index(){
		ModelAndView mav = new ModelAndView("t:index");
		return mav;
	}
	
	// login
	@RequestMapping("/login/{id}/{pw}")
	@ResponseBody
	public boolean login(@PathVariable(name="id")String id, @PathVariable(name="pw")String pw, HttpSession session){
		return ms.login(id, pw, session);
	}
	
	// program login
	@RequestMapping("/login_p/{id}/{pw}")
	@ResponseBody
	public HashMap login_p(@PathVariable(name="id")String id, @PathVariable(name="pw")String pw){
		return ms.login_p(id, pw);
	}
	
	// logout
	@RequestMapping("/logout")
	public String logout(HttpSession session){
		ms.logout(session);
		return "redirect:/";
	}
}
