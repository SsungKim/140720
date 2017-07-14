package play.controller;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import play.service.*;

@Controller
@RequestMapping("/play")
public class PlayController {
	@Autowired
	PlayService ps;
	
	// play index
	@RequestMapping("")
	public ModelAndView play(){
		ModelAndView mav = new ModelAndView("t:play/play");
		return mav;
	}
}
