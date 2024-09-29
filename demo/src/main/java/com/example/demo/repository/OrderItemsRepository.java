package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.model.OrderItems;
import com.example.demo.model.Orders;

public interface OrderItemsRepository  extends JpaRepository<OrderItems,Long>{
	List<OrderItems> findAllByOrders(Orders orders);
	List<OrderItems> deleteAllByOrders(Orders orders);
	boolean existsByOrders(Orders orders);
}
