package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.model.Cart;
import com.example.demo.model.User;

public interface CartRepository extends JpaRepository<Cart,Long>{
	List<Cart> findByUser(User user);
	List<Cart> deleteAllByUser(User user);

}
