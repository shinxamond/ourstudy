package kr.spring.map.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MapController {
	@RequestMapping("/map/showmap.do")
	public String form() {
		return "showMap";
	}
}
