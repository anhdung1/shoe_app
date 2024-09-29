package com.example.demo.service;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;


import com.example.demo.model.OrderItems;
import com.example.demo.model.OrderItemsRequestDTO;

@Service
public class OrderItemsService {
	public List<OrderItemsRequestDTO> transOrderItems(List<OrderItems> ordersItems) {
		return ordersItems.stream().map(orderItem -> {
            String productTitle = orderItem.getProduct().getTitle();
            float productPrice = orderItem.getProduct().getPrice();
 
            String productImage=orderItem.getProduct().getImage();
     
            return new OrderItemsRequestDTO(productTitle, productPrice,productImage);
        }).collect(Collectors.toList());
	}
	}
