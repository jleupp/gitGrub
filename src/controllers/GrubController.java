package controllers;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import data.GrubRestaurantDAO;

@Controller
public class GrubController {

	@Autowired
	private GrubRestaurantDAO grubrdao = new GrubRestaurantDAO();
	
	@RequestMapping(path = "Form.do", params = "user", method = RequestMethod.POST)

	public ModelAndView getName(@RequestParam("firstname") String n) {
		ModelAndView mv = new ModelAndView();

		mv.setViewName("FrontPage.jsp");
		mv.addObject("newname", n);
		return mv;
	}
	
	
	
	public ModelAndView getCustomerList(@RequestParam("") String n) {
		ModelAndView mv = new ModelAndView();

		mv.setViewName("jsp");
		mv.addObject("", n);
		return mv;
	}
}
