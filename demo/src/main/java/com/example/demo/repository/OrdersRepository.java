package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.stereotype.Repository;

import com.example.demo.model.Orders;
import com.example.demo.model.User;

@Repository
public interface OrdersRepository extends JpaRepository<Orders, Long> {

	List<Orders> findByUser(User user);
	boolean existsByCode(String code);
	Orders findByCode(String code);

}