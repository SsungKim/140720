package culture.controller;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import culture.service.*;

@Controller
@RequestMapping("/culture")
public class CultureController {
	@Autowired
	CultureService cs;

	// culture index
	@RequestMapping("")
	public ModelAndView culture(){
		ModelAndView mav = new ModelAndView("t:culture/culture");
		return mav;
	}
}
