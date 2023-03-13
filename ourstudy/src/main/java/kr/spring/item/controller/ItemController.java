package kr.spring.item.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.ibatis.annotations.Select;
import org.apache.tiles.autotag.core.runtime.annotation.Parameter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.item.dao.ItemMapper;
import kr.spring.item.service.ItemService;
import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;

@Controller
public class ItemController {
	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);

	@Autowired
	private ItemService itemService;

	//자바빈(VO) 초기화
	@ModelAttribute
	public ItemVO initCommand() {
		return new ItemVO();
	}

	//=====목록 생성(유저)======//
	@RequestMapping("/item/userList.do")
	public ModelAndView userList(@RequestParam(value="pageNum", defaultValue="1")int currentPage) {
		Map<String,Object> map = new HashMap<String, Object>();

		int count = itemService.selectCount();//표시여부 값
		logger.debug("<<count>> : " + count);

		PagingUtil page = new PagingUtil(currentPage, count, count, 1, "/item/itemList.do");

		List <ItemVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = itemService.selectList(map);
		}
		logger.debug("<<list>> : " + list);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("userList");//타일스값
		mav.addObject("count", count);
		mav.addObject("list",list);
		return mav;
	}
	//=====대여 목록 생성(유저)======//
	@RequestMapping("/item/rentalItemList.do")
	public ModelAndView rentalItemList(@RequestParam(value="pageNum", defaultValue="1")int currentPage, HttpSession session, Model model, HttpServletRequest request) {
		Map<String,Object> map = new HashMap<String, Object>();

		MemberVO user = (MemberVO)session.getAttribute("user");

		int rentalItemCount = itemService.rentalItemCount(2, user.getMem_num());//표시여부 값
		logger.debug("<<대여목록count>> : " + rentalItemCount);
		
		
		PagingUtil page = new PagingUtil(currentPage, rentalItemCount, rentalItemCount, 1, "/item/rentalItemList.do");

		List <ItemVO> list = null;
		map.put("item_r_status", 2);
		map.put("mem_num", user.getMem_num());
		if(rentalItemCount > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = itemService.rentalItemList(map);
		}
		logger.debug("<<대여목록list>> : " + list);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("rentalItemList");//타일스값
		mav.addObject("count", rentalItemCount);
		mav.addObject("list",list);
		return mav;
	}
	//==========물품 대여 폼(유저)=========//
	@RequestMapping("/item/userRental.do")
	public ModelAndView itemDetail(@RequestParam int item_index) {

		logger.debug("<<item_index>> : " + item_index);

		List<ItemVO> list = null;
		list = itemService.selectDetailList(item_index);
		int count = itemService.selectItemCount(item_index);
		//물품명 식별번호에 속한 물품중 하나의 물품
		ItemVO oneitem = itemService.selectIndexItem(item_index);
		

		ModelAndView mav = new ModelAndView();
		mav.setViewName("userRental");//타일스값
		mav.addObject("list",list);
		mav.addObject("count",count);
		mav.addObject("oneitem", oneitem);
		return mav;
	}
	//============물품 대여===========//
	@PostMapping("/item/userItemRental.do")
	public String itemRental(ItemVO itemVO, HttpSession session, Model model, HttpServletRequest request) {
		logger.debug("<<물품 대여>> : " + itemVO);
		if(session.getAttribute("user")==null) {
			model.addAttribute("message", "로그인 필수");
			model.addAttribute("url", request.getContextPath()+"/item/userList.do");
			return "common/resultView";
		}
		//세션값
		MemberVO user = (MemberVO)session.getAttribute("user");

		ItemVO item = itemService.selectItem(itemVO.getItem_num());
		item.setMem_num(user.getMem_num());

		int distinctCount = itemService.itemDistinct(item.getItem_index(), user.getMem_num(), 1);
		
		
		
		if(distinctCount > 0 ) {
			model.addAttribute("message", "동일한 물품 1개만 대여 가능");
			model.addAttribute("url", request.getContextPath()+"/item/userList.do");
			return "common/resultView";
		}

		itemService.Rstatus(2, item.getItem_num());//대여상태 변경
		itemService.Rental(item);//대여
		logger.debug("<<물품 대여 완료>> : " + item);
		return "redirect:/item/userList.do";
	}

	//============물품 반납===========//
	@GetMapping("/item/userItemReturn.do")
	public String itemReturn(@RequestParam int item_num, Model model, HttpServletRequest request) {
		logger.debug("<<물품 반납>> : " + item_num);

		itemService.Rstatus(3, item_num);//대여상태 변경

		model.addAttribute("message", "반납신청완료");
		model.addAttribute("url", request.getContextPath()+"/mypage/myPageMain.do");
		return "common/resultView";
	}
	
	//============관리자 물품 반납===========//
	@GetMapping("/item/adminItemReturn.do")
	public String itemAdminReturn(@RequestParam int item_num, Model model, HttpServletRequest request) {
		logger.debug("<<물품 반납>> : " + item_num);

		itemService.Rstatus(1, item_num);//대여상태 변경
		itemService.Return(item_num);//반납
		
		model.addAttribute("message", "반납완료");
		model.addAttribute("url", request.getContextPath()+"/item/adminList.do");
		return "common/resultView";
	}


	//=======목록 생성(관리자)===========//
	@RequestMapping("/item/adminList.do")
	public ModelAndView adminList(@RequestParam(value="pageNum", defaultValue="1")int currentPage, String keyfield, String keyword ) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		int count = itemService.selectAdminCount(map);
		logger.debug("<<관리자 - count>> : " + count);

		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 25, 10, "adminList.do");

		List <ItemVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = itemService.selectAdminList(map);
		}
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminList");//타일스값
		mav.addObject("count", count);
		mav.addObject("list",list);
		mav.addObject("page",page.getPage());
		return mav;
	}

	//=====물품 생성======//
	@GetMapping("/item/itemWrite.do")
	public String itemWrite() {
		return "itemWrite";//타일스값
	}

	@PostMapping("/item/itemWrite.do")
	public String submititem(@Valid ItemVO itemVO, BindingResult result, Model model, HttpServletRequest request) {
		logger.debug("<<물품 생성>> : " + itemVO);

		if(itemVO.getItem_ufile().length==0) {
			//upload는 자바빈(VO)에 팔드가 없기 때문에 명시 할 수 없음
			result.rejectValue("item_ufile", "required");
		}
		//이미지 용량 체크
		if(itemVO.getItem_ufile().length > 5*1024*1024) {//5MB    {"5MB"} validation.properties에 limitUploadSize {0}을 의미 
			result.rejectValue("item_ufile", "limitUploadSize",new Object[] {"5MB"},null);
		}
		if(result.hasErrors()) {
			return itemWrite();
		}
		itemService.insertItem(itemVO);

		model.addAttribute("message", "물품 생성 완료");
		model.addAttribute("url", request.getContextPath()+"/item/adminList.do");
		return "common/resultView";

	}

	//======물품 수정=======//
	@GetMapping("/item/itemModify.do")
	public String itemModify(@RequestParam int item_num, Model model) {

		ItemVO item = itemService.selectItem(item_num);
		logger.debug("<<물품수정전>> : " + item);
		model.addAttribute("itemVO", item);

		return "itemModify";
	}
	@PostMapping("/item/itemModify.do")
	public String submitModify(@Valid ItemVO itemVO, BindingResult result, Model model, HttpServletRequest request) {

		logger.debug("<<물품수정후>> : " + itemVO);
		ItemVO vo = itemService.selectItem(itemVO.getItem_num());
		
			if(itemVO.getItem_ufile().length==0 && vo.getItem_ufile()==null) {
				//upload는 자바빈(VO)에 팔드가 없기 때문에 명시 할 수 없음
				result.rejectValue("item_ufile", "required");
			}
			
		
		//이미지 용량 체크
		if(itemVO.getItem_ufile().length > 5*1024*1024) {//5MB    {"5MB"} validation.properties에 limitUploadSize {0}을 의미 
			result.rejectValue("item_ufile", "limitUploadSize",new Object[] {"5MB"},null);
		}

		if(result.hasErrors()) {
			
			itemVO.setItem_imgsrc(vo.getItem_imgsrc());
			return "itemModify";
		}
		//ItemVO vo = itemService.selectItem(itemVO.getItem_num());
		if(vo.getItem_r_status()!= 1) {
			model.addAttribute("message", "대여중인 물품 수정 불가능");
			model.addAttribute("url", request.getContextPath()+"/item/adminList.do");
			return "common/resultView";
		}

		itemService.updateItem(itemVO);

		return "redirect:/item/adminList.do";
	}

	//========물품 삭제==========//
	@RequestMapping("/item/itemDelete.do")
	public String itemDelete(@RequestParam int item_num, Model model, HttpServletRequest request) {

		logger.debug("<<물품 삭제>> : " + item_num);
		ItemVO item = itemService.selectItem(item_num);
		if(item.getItem_r_status()!= 1) {
			model.addAttribute("message", "대여중인 물품 삭제 불가능");
			model.addAttribute("url", request.getContextPath()+"/item/adminList.do");
			return "common/resultView";
		}
		//물품 상세 삭제
		itemService.deleteItemDetail(item_num);
		//물품 삭제
		itemService.deleteItem(item_num);
		

		return "redirect:/item/adminList.do";
	}

	//=======파일 삭제==========//
	@RequestMapping("/item/deleteFile.do")
	@ResponseBody//json
	public Map<String,String> deleteFile(int item_num){
		Map<String,String> mapJson = new HashMap<String, String>();

		itemService.deleteFile(item_num);
		mapJson.put("result", "success");
		return mapJson;
	}

	//이미지 출력
	@RequestMapping("/item/imageView.do")
	public ModelAndView getItemImage(@RequestParam int item_num) {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView");
		ItemVO itemVO = itemService.selectItem(item_num);
		mav.addObject("imageFile", itemVO.getItem_ufile());
		mav.addObject("filename", itemVO.getItem_imgsrc());

		return mav;
	}

}













