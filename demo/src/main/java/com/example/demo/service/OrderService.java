package com.example.demo.service;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;


import com.example.demo.model.Orders;
import com.example.demo.model.Orders.OrderStatus;
import com.example.demo.model.OrdersDTO;
@Service
public class OrderService {
	public List<OrdersDTO> transOrdersDTO(List<Orders> orders) {
		return orders.stream().map(order -> {
            String totalAmount=order.getTotalAmount();
            OrderStatus status=order.getStatus();
            Long orderId=order.getId();
            String code=order.getCode();
            return new OrdersDTO(orderId, status, totalAmount,code);
        }).collect(Collectors.toList());
	}
	}