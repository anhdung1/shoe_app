package com.example.demo.model;

import com.example.demo.model.Orders.OrderStatus;

public class OrdersDTO {
	private Long orderId;
	private OrderStatus status;
	private String totalAmount;
	private String code;
	public OrdersDTO(Long orderId,OrderStatus status,String totalAmount,String code) {
		this.status=status;
		this.totalAmount=totalAmount;
		this.orderId=orderId;
		this.code=code;
	}
	public OrderStatus getStatus() {
		return status;
	}
	public void setStatus(OrderStatus status) {
		this.status = status;
	}
	public Long getOrderId() {
		return orderId;
	}
	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}
	public String getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(String totalAmount) {
		this.totalAmount = totalAmount;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
}
