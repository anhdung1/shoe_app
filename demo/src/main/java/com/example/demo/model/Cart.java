package com.example.demo.model;


import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;

@Entity
public class Cart {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long cart_id;
	
	private Long quantity;
	@OneToMany(mappedBy="cart",cascade=CascadeType.ALL)
	
	@ManyToOne
	@JoinColumn(name="product_id", nullable = false)
	private Product product;
	@ManyToOne
	@JoinColumn(name="user_id", nullable = false)
	private User user;
	@JsonIgnore
	public Long getId() {
		return cart_id;
	}
	public void setProduct(Product product) {
		this.product=product;
	}
	public Product getProduct() {
		return product;
	}
	public void setUser(User user) {
		this.user=user;
	}
	public User getUser() {
		return user;
	}
	public Long getQuantity() {
		return quantity;
	}
	public void setQuantity(Long quantity) {
		this.quantity = quantity;
	}

}
