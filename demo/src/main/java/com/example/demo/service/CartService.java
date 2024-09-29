package com.example.demo.service;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.example.demo.model.Cart;
import com.example.demo.model.CartDto;
@Service
public class CartService {
	public List<CartDto> transCart(List<Cart> carts) {
		return carts.stream().map(cart -> {
            String productTitle = cart.getProduct().getTitle();
            float productPrice = cart.getProduct().getPrice();
            String username1 = cart.getUser().getUsername();
            String productImage=cart.getProduct().getImage();
            Long quantity=cart.getQuantity();
            Long productId=cart.getProduct().getId();
            return new CartDto(productTitle, productPrice, username1,productImage,quantity,productId);
        }).collect(Collectors.toList());
	}
	}
