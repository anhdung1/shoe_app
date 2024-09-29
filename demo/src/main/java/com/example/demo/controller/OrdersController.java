package com.example.demo.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


import com.example.demo.model.OrderItems;
import com.example.demo.model.OrderItemsDTO;
import com.example.demo.model.OrderItemsRequestDTO;
import com.example.demo.model.Orders;
import com.example.demo.model.OrdersDTO;
import com.example.demo.model.Product;
import com.example.demo.model.User;
import com.example.demo.repository.OrderItemsRepository;
import com.example.demo.repository.OrdersRepository;
import com.example.demo.repository.ProductRepository;
import com.example.demo.repository.UserRepository;
import com.example.demo.service.OrderCodeGenerator;
import com.example.demo.service.OrderItemsService;
import com.example.demo.service.OrderService;

import jakarta.transaction.Transactional;


@RestController
@RequestMapping("/user/orders")
public class OrdersController {
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private ProductRepository productRepository;
	@Autowired
	private OrderService orderService;
    @Autowired
    private OrderItemsService orderItemsService;
    @Autowired
    private OrdersRepository ordersRepository;
    @Autowired
    private OrderItemsRepository orderItemsRepository;
    @GetMapping("/{userId}")
    public ResponseEntity<List<OrdersDTO>> getOrders(@PathVariable Long userId){
    	User user=userRepository.findById(userId).orElseThrow();
    	List<Orders> orders=ordersRepository.findByUser(user);
    	if(orders.isEmpty()) {
    		return ResponseEntity.notFound().build();
    	}
    	
    	return ResponseEntity.ok(orderService.transOrdersDTO(orders));
    }
    @GetMapping("/admin")
    public ResponseEntity<Orders> findByCode(@RequestParam String code){
    	Orders order=ordersRepository.findByCode(code);
    	if(order!=null) {
    		return  ResponseEntity.ok(order);
    	}
    	return ResponseEntity.notFound().build();
    }
    @PatchMapping("/edit/admin")

    public ResponseEntity<Orders> editStatus(@RequestParam String status,@RequestParam String code){
    	Orders order=ordersRepository.findByCode(code);
    	 if (order != null) {
    	        try {
    	 
    	            Orders.OrderStatus newStatus = Orders.OrderStatus.valueOf(status);
    	            order.setStatus(newStatus);
    	            ordersRepository.save(order); 
    	            return ResponseEntity.ok(order);
    	        } catch (IllegalArgumentException e) {
    	        
    	            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
    	                    .body(null); 
    	        }
    	    }
    	return ResponseEntity.notFound().build();
    }
    @GetMapping("/orderitems/{code}")
    public ResponseEntity<List<OrderItemsRequestDTO>> getOrderItems(@PathVariable String code){
    	Orders order=ordersRepository.findByCode(code);
    	if(order==null) {
    	
    	
    		return ResponseEntity.notFound().build();
    	}
    	List<OrderItems>orderItems=orderItemsRepository.findAllByOrders(order);
    	return  ResponseEntity.ok(orderItemsService.transOrderItems(orderItems));
    }
    @Transactional
    @DeleteMapping
    public ResponseEntity<String> removeOrders(@RequestParam Long orderId){
    	Orders order=ordersRepository.findById(orderId).orElseThrow(null);
    	boolean orderItems=orderItemsRepository.existsByOrders(order);
    	if(orderItems) {
    		orderItemsRepository.deleteAllByOrders(order);
    		return ResponseEntity.ok("Remove success");
    	}
    	 return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Orders not found");
    	
    }
    @PostMapping("/newOrders")
    public ResponseEntity<?> createOrders(@RequestBody List<OrderItemsDTO> listOrderItemsDTO,@RequestParam Long userId,@RequestParam float totalAmount ){
    	 String orderCode = OrderCodeGenerator.generateOrderCode();
    	while(ordersRepository.existsByCode(orderCode)) {
    		 orderCode = OrderCodeGenerator.generateOrderCode();
    	};
    	User user= userRepository.findById(userId).orElseThrow();
    	Orders order=new Orders();
    
    	order.setStatus(Orders.OrderStatus.Success);
    	order.setTotalAmount(String.valueOf(totalAmount));
    	order.setUser(user);
    	order.setCode(orderCode);
    	ordersRepository.save(order);
    	for(OrderItemsDTO orderItemsDTO:listOrderItemsDTO) {
    		Product product=productRepository.findById(orderItemsDTO.getProductId()).orElseThrow();
    		OrderItems orderItem=new OrderItems();
    		orderItem.setOrders(order);
    		orderItem.setProduct(product);
    		orderItem.setQuantity(orderItemsDTO.getQuantity());
    		orderItemsRepository.save(orderItem);
    	}
    	return ResponseEntity.ok("ok");
    
    }

}