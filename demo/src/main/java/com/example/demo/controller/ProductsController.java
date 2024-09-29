package com.example.demo.controller;


import com.example.demo.model.Category;
import com.example.demo.model.Product;
import com.example.demo.repository.CategoryRepository;
import com.example.demo.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user/products")
public class ProductsController {

    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private CategoryRepository categoryRepository;
    @GetMapping
    public ResponseEntity<List<Product>> getAllProducts() {
        List<Product> products = productRepository.findAll();
        
        if (products.isEmpty()) {
            return ResponseEntity.noContent().build();
        }
        for(Product product:products) {
        	System.out.print(product.getCategory());
        }
       
        return ResponseEntity.ok(products);
    }
	    @PostMapping("/admin")
	    public ResponseEntity<?> createProduct(@RequestBody Product product) {
	    	 Category category = product.getCategory();
	    	    if (category != null) {
	    	        Category existingCategory = categoryRepository.findByName(category.getName());
	    	        if (existingCategory != null) {
	    	            product.setCategory(existingCategory); 
	    	        } else {
	    	           
	    	            category = categoryRepository.save(category);
	    	            product.setCategory(category);
	    	        }
	    	    }
	        if (product.getPrice() == null || product.getTitle() == null || product.getDescription() == null || product.getImage() == null 
	            || product.getTitle().isEmpty() || product.getDescription().isEmpty() || product.getImage().isEmpty()) {
	            return ResponseEntity.badRequest().body("All fields (price, title, description, image) are required and cannot be null or empty.");
	        }
	      
	        productRepository.save(product);
	       
	        return ResponseEntity.ok("Product added successfully");
	    }

    @GetMapping("/{id}")
    public Product getProductById(@PathVariable Long id) {
        return productRepository.findById(id).orElse(null);
    }

    @PutMapping("/{id}")
    public Product updateProduct(@PathVariable Long id, @RequestBody Product product) {
        if (productRepository.existsById(id)) {
            product.setId(id);
            return productRepository.save(product);
        }
        return null;
    }

    @DeleteMapping("/{id}")
    public void deleteProduct(@PathVariable Long id) {
    	productRepository.deleteById(id);
    }
    @GetMapping("/search")
    public ResponseEntity<List<Product>> searchProducts(@RequestParam String title){
    	List<Product> products;
    	if(title==null) {
    		 products=productRepository.findAll();
    		return ResponseEntity.ok(products);
    	}
    	products=productRepository.findByTitleContaining(title);
    	if(!products.isEmpty()) {
    		
    		return ResponseEntity.ok(products);
    	}
    	return ResponseEntity.notFound().build();
    }

}

