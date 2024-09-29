package com.example.demo.repository;
import com.example.demo.model.Product;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
public interface ProductRepository extends JpaRepository<Product, Long>{
	@Query("SELECT p FROM Product p WHERE p.title LIKE %:title%")
	List<Product>findByTitleContaining(@Param("title") String title);
}
