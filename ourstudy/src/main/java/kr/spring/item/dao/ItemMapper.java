package kr.spring.item.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.item.vo.ItemVO;

@Mapper
public interface ItemMapper {
	//물품추가
	@Insert("INSERT INTO item (item_num,item_index,item_title,item_ufile,item_imgsrc,item_p_status,item_time) "
			+ "VALUES (item_seq.nextval,#{item_index},#{item_title},#{item_ufile},#{item_imgsrc},#{item_p_status},#{item_time})")
	public void insertItem(ItemVO item);
	//물품삭제
	@Delete("DELETE FROM item WHERE item_num=#{item_num}")
	public void deleteItem(Integer item_num);
	//물품상세정보삭제
	@Delete("DELETE FROM item_detail WHERE item_num=#{item_num}")
	public void deleteItemDetail(Integer item_num);
	//물품수정
	public void updateItem(ItemVO item);

	//표시물품 개수(회원)
	@Select("SELECT count(DISTINCT item_index) FROM item")
	public int selectCount();
	//표시물품 리스트(회원)
	public List<ItemVO> selectList(Map<String,Object> map);

	//표시물품 개수(관리자)
	public int selectAdminCount (Map<String,Object> map);
	//물품 리스트(관리자)
	public List<ItemVO> selectAdminList(Map<String,Object> map);

	//이미지 삭제
	@Update("UPDATE item SET item_ufile='', item_imgsrc='' WHERE item_num=#{item_num}")
	public void deleteFile(Integer item_num);

	//물품 상세
	@Select("SELECT * FROM item WHERE item_num=#{item_num}")
	public ItemVO selectItem(Integer item_num);
	//물품명 식별번호에 속한 물품중 하나의 물품
	@Select("SELECT * FROM item WHERE item_num = (SELECT max(item_num) FROM item WHERE item_index=#{item_index} AND item_p_status=1)")  						  
	public ItemVO selectIndexItem(Integer item_index);
	
	//물품명 식별번호에 따른 물품 개수
	@Select("SELECT count(*) FROM item WHERE item_index=#{item_index} AND item_p_status=1 AND item_r_status=1")
	public int selectItemCount (Integer item_index);
	//물품명에 따른 물품 상세
	@Select("SELECT * FROM item WHERE item_index=#{item_index} AND item_p_status=1 AND item_r_status=1")
	public List<ItemVO> selectDetailList(Integer item_index);
	
	//대여 물품 리스트 개수
	@Select("SELECT count(*) FROM item i JOIN item_detail d USING(item_num) WHERE i.item_r_status>=#{item_r_status} AND d.mem_num=#{mem_num} AND d.item_end IS NULL")
	public int rentalItemCount(@Param(value="item_r_status")int item_r_status, @Param(value="mem_num")int mem_num);
	//대여 물품 리스트
	public List<ItemVO> rentalItemList(Map<String,Object> map);
	
	//대여
	@Insert("Insert INTO item_detail (item_rnum,item_num,item_utime,mem_num) "
			+ "VALUES (item_detail_seq.nextval,#{item_num},SYSDATE+#{item_time}, #{mem_num})")
	public void Rental(ItemVO item);
	//대여상태 변경
	@Update("UPDATE item SET item_r_status=#{item_r_status} WHERE item_num=#{item_num}")
	public void Rstatus(@Param(value="item_r_status")int item_r_status, @Param(value="item_num")int item_num);
	//동일한 물품 빌렸는지 확인
	@Select("SELECT count(*) FROM item i JOIN item_detail d USING(item_num) WHERE i.item_index=#{item_index} AND d.mem_num=#{mem_num} AND i.item_r_status > #{item_r_status}")
	public int itemDistinct(@Param(value="item_index")int item_index, @Param(value="mem_num")int mem_num, @Param(value="item_r_status")int item_r_status);
	//반납
	@Update("UPDATE item_detail SET item_end=SYSDATE WHERE item_num=#{item_num}")
	public void Return(Integer item_num);
}
