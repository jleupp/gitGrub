package controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import data.GrubDAO;

@Controller
@SessionAttributes({"personCred", "orderList"})
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
}
