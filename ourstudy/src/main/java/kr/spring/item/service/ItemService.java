package kr.spring.item.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.item.vo.ItemVO;

public interface ItemService {
	//물품추가
	public void insertItem(ItemVO item);
	//물품삭제
	public void deleteItem(Integer item_num);
	//물품상세정보삭제
	public void deleteItemDetail(Integer item_num);
	//물품수정
	public void updateItem(ItemVO item);
	//물품 개수
	public int selectCount();
	//물품 리스트
	public List<ItemVO> selectList(Map<String,Object> map);
	//표시물품 개수(관리자)
	public int selectAdminCount (Map<String,Object> map);
	//물품 리스트(관리자)
	public List<ItemVO> selectAdminList(Map<String,Object> map);
	//물품 상세
	public List<ItemVO> selectDetailList(Integer item_index);
	//대여 물품 리스트 개수
	public int rentalItemCount(@Param(value="item_r_status")int item_r_status, @Param(value="mem_num")int mem_num);
	//대여 물품 리스트
	public List<ItemVO> rentalItemList(Map<String,Object> map);
	//대여
	public void Rental(ItemVO item);
	//대여상태 변경
	public void Rstatus(@Param(value="item_r_status")int item_r_status, @Param(value="item_num")int item_num);
	//반납
	public void Return(Integer item_num);
	//이미지처리
	public ItemVO selectItem(Integer item_num);
	//파일삭제
	public void deleteFile(Integer item_num);
	//물품명 식별 번호에 따른 물품 개수
	public int selectItemCount (Integer item_index);
	//물품명 식별번호에 속한 물품중 하나의 물품  						  
	public ItemVO selectIndexItem(Integer item_index);
	//동일한 물품 빌렸는지 확인
	public int itemDistinct(@Param(value="item_index")int item_index, @Param(value="mem_num")int mem_num, @Param(value="item_r_status")int item_r_status);
}
