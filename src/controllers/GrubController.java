package controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import data.GrubDAO;

@Controller
public class GrubController {
	@Autowired
	private GrubDAO grubdao;
}
