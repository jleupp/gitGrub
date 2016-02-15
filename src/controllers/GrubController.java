package controllers;

<<<<<<< HEAD
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
	private GrubDAO grubDAO;

	@ModelAttribute("personCred")
	public String setPersonCred() {
		String s = "person creds class";
		return s;
	}

	@ModelAttribute("orderList")
	public String initOrderList() {
		//HERE WE WILL INIT AN ORDER ENTITY
		//THE ORDER ENTITY HAS A LIST OF ORDER DETAIL OBJECTS
		String s = "Order Entity Instantiation";
		return s;
	}

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
