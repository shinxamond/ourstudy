package kr.spring.item.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.item.dao.ItemMapper;
import kr.spring.item.vo.ItemVO;

@Service
@Transactional
public class ItemServiceImpl implements ItemService{
	
	@Autowired
	private ItemMapper itemMapper;
	
	@Override
	public void insertItem(ItemVO item) {
		itemMapper.insertItem(item);
	}

	@Override
	public void deleteItem(Integer item_num) {
		itemMapper.deleteItem(item_num);
	}

	@Override
	public void updateItem(ItemVO item) {
		itemMapper.updateItem(item);
	}

	@Override
	public int selectCount() {
		return itemMapper.selectCount();
	}

	@Override
	public List<ItemVO> selectList(Map<String, Object> map) {
		return itemMapper.selectList(map);
	}

	@Override
	public List<ItemVO> selectDetailList(Integer item_index) {
		return itemMapper.selectDetailList(item_index);
	}

	@Override
	public void Rental(ItemVO item) {
		itemMapper.Rental(item);
	}

	@Override
	public void Return(Integer item_num) {
		itemMapper.Return(item_num);
	}

	@Override
	public ItemVO selectItem(Integer item_num) {
		return itemMapper.selectItem(item_num);
	}

	@Override
	public int selectAdminCount(Map<String, Object> map) {
		return itemMapper.selectAdminCount(map);
	}

	@Override
	public List<ItemVO> selectAdminList(Map<String, Object> map) {
		return itemMapper.selectAdminList(map);
	}

	@Override
	public void deleteFile(Integer item_num) {
		itemMapper.deleteFile(item_num);
	}

	@Override
	public int selectItemCount(Integer item_index) {
		return itemMapper.selectItemCount(item_index);
	}

	@Override
	public ItemVO selectIndexItem(Integer item_index) {
		return itemMapper.selectIndexItem(item_index);
	}

	@Override
	public void Rstatus(int item_r_status, int item_num) {
		itemMapper.Rstatus(item_r_status, item_num);
	}

	@Override
	public int itemDistinct(int item_index, int mem_num) {
		return itemMapper.itemDistinct(item_index, mem_num);
	}

	@Override
	public int rentalItemCount(int item_r_status, int mem_num) {
		return itemMapper.rentalItemCount(item_r_status, mem_num);
	}

	@Override
	public List<ItemVO> rentalItemList(Map<String, Object> map) {
		return itemMapper.rentalItemList(map);
	}

	

}
