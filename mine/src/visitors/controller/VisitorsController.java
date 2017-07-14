package visitors.controller;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

@Controller
@RequestMapping("/visitors")
public class VisitorsController {
	
	// visitors index
	@RequestMapping("")
	public ModelAndView viistors(){
		ModelAndView mav = new ModelAndView("t:visitors/visitors");
		return mav;
	}
}
