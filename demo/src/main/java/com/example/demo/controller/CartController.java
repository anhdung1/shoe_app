package com.example.demo.controller;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.model.Cart;
import com.example.demo.model.CartDto;
import com.example.demo.model.CartRequestDTO;
import com.example.demo.model.Product;
import com.example.demo.model.User;
import com.example.demo.repository.CartRepository;
import com.example.demo.repository.ProductRepository;
import com.example.demo.repository.UserRepository;
import com.example.demo.service.CartService;

import jakarta.transaction.Transactional;


@RestController
@RequestMapping("/user/carts")
public class CartController {
	@Autowired
	CartRepository cartRepository;
	@Autowired
    private UserRepository userRepository;
	@Autowired
    private ProductRepository productRepository;
	@Autowired
	CartService cartService;
	@GetMapping("/{userId}")
	public  List<CartDto> getCardUserId(@PathVariable Long userId  ){

		User user=userRepository.findById(userId).orElseThrow();
	
			List<Cart>carts=cartRepository.findByUser(user);
			return cartService.transCart(carts);
			}
	@GetMapping("/pay/{username}")
	public  ResponseEntity<BigDecimal> getPrice(@PathVariable String username){
				
		User user=userRepository.findByUsername(username);
	
			List<Cart>carts=cartRepository.findByUser(user);
			float price= 0;
			for(Cart cart:carts) {
				price+=cart.getQuantity()*cart.getProduct().getPrice();
			}
			BigDecimal roundedPrice = new BigDecimal(price).setScale(2, RoundingMode.HALF_UP);
			return ResponseEntity.ok(roundedPrice);
			
			}
	@Transactional
	@DeleteMapping("/pay/next/{username}")
	public  ResponseEntity<String> payCart(@PathVariable String username){
		
		User user=userRepository.findByUsername(username);
		if(user==null) {
			return ResponseEntity.notFound().build();
		}
	
			cartRepository.deleteAllByUser(user);
			
			return ResponseEntity.ok("");
			}
	
	@DeleteMapping("/remove")
	public  ResponseEntity<String> removeCart(@RequestBody CartRequestDTO cartRequestDTO){
		System.out.print(cartRequestDTO.getUserId());
		System.out.print(cartRequestDTO.getProductId());
		User user=userRepository.findById(cartRequestDTO.getUserId()).orElseThrow();
		List<Cart>carts=cartRepository.findByUser(user);
			for(Cart cart:carts) {
				if(cart.getProduct().getId().equals(cartRequestDTO.getProductId())) {
					cartRepository.deleteById(cart.getId());
					return ResponseEntity.ok("");		
					}
			}
			
			return ResponseEntity.notFound().build();
			}
	@PutMapping
	public ResponseEntity<Cart> editCart(@RequestBody CartRequestDTO cartRequestDTO){
		List<Cart>carts=cartRepository.findAll();
		 for(Cart cartIncarts : carts ) {
				if(cartIncarts.getUser().getId().equals(cartRequestDTO.getUserId())&&cartIncarts.getProduct().getId().equals(cartRequestDTO.getProductId())) {
					cartIncarts.setQuantity(cartRequestDTO.getQuantity());
					cartRepository.save(cartIncarts);
					return ResponseEntity.ok(cartIncarts);
				}
			}
		 return ResponseEntity.notFound().build();
	}
	@PostMapping
	public ResponseEntity<String> createCart(@RequestBody CartRequestDTO cartRequestDTO) {
		List<Cart>carts=cartRepository.findAll();
		
		 Product product = productRepository.findById(cartRequestDTO.getProductId())
		            .orElseThrow();
		 User user = userRepository.findById(cartRequestDTO.getUserId())
		            .orElseThrow();
		 for(Cart cartIncarts : carts ) {
				if(cartIncarts.getUser().getId().equals(cartRequestDTO.getUserId())&&cartIncarts.getProduct().getId().equals(cartRequestDTO.getProductId())) {
					cartIncarts.setQuantity(cartIncarts.getQuantity()+1);
					cartRepository.save(cartIncarts);
					return ResponseEntity.ok("Cart +1");
				}
			}
		
		Cart cart=new Cart();
		cart.setUser(user);
		cart.setProduct(product);
		cart.setQuantity(cartRequestDTO.getQuantity());
		cartRepository.save(cart);
		return ResponseEntity.ok("Cart added successfully");
	}
	@GetMapping
    public List<CartDto> getAllCarts() {
 
        List<Cart> carts = cartRepository.findAll();
        

        return cartService.transCart(carts);
    }

}
