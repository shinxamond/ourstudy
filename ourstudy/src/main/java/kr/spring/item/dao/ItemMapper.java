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
	@Delete("DELETE FROM item WHERE item_num=#{item_num} AND item_p_status=1")
	public void deleteItem(Integer item_num);
	//물품수정
	@Update("UPDATE item SET item_index=#{item_index}, item_title=#{item_title}, item_ufile=#{item_ufile},item_imgsrc=#{item_imgsrc},"
			+ "item_p_status=#{item_p_status}, item_time=#{item_time} WHERE item_num=#{item_num}")
	public void updateItem(ItemVO item);
	
	//표시물품 개수(회원)
	@Select("SELECT count(DISTINCT item_index) FROM item WHERE item_p_status=#{item_p_status}")
	public int selectCount (Integer item_p_status);
	//물품 리스트(회원)
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
	//물품명에 따른 물품 상세
	@Select("SELECT * FROM item WHERE item_index=#{item_index} AND item_p_status=1")
	public List<ItemVO> selectDetailList(Integer item_index);
	//대여
	@Insert("Insert INTO item_detail (item_rnum,item_num,item_utime,mem_num) "
			+ "VALUES (item_detail_seq.nextval,#{item_num},SYSDATE+#{time}, #{mem_num})")
	public void Rental(Integer item_num);
	//대여상태 변경
	@Update("UPDATE item SET item_r_status=#{item_r_status} WHERE item_num=#{item_num}")
	public void Rstatus(@Param(value="item_r_status")int item_r_status, @Param(value="item_num")int item_num);
	//반납
	@Update("UPDATE item_detail SET item_end=SYSDATE WHERE item_num=#{item_num}")
	public void Return(Integer item_num);
}
