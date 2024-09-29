package com.example.demo.model;

import java.util.List;


import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;

@Entity
public class Product {
	 @Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    private Long id;
	    private String title;
	    private String description;

	    private String  image;
	    private float rate;
	    private int count;
	    private Float price;
	    @OneToMany(mappedBy = "product")

	    private List<Cart> carts;
	    @OneToMany(mappedBy = "product")
	    private List<OrderItems> orderItems;
	    @ManyToOne
	    @JoinColumn(name = "category_id", nullable = false)
	    private Category category;
	    public Long getId() {
	        return id;
	    }

	    public void setId(Long id) {
	        this.id = id;
	    }
		public String getDescription() {
			return description;
		}
		public void setDescription(String description) {
			this.description = description;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public float getRate() {
			return rate;
		}
		public void setRate(float rate) {
			this.rate = rate;
		}
		public String getImage() {
			return image;
		}
		public void setImage(String image) {
			this.image = image;
		}
		public int getCount() {
			return count;
		}
		public void setCount(int count) {
			this.count = count;
		}

		public Float getPrice() {
			return price;
		}

		public void setPrice(float price) {
			this.price = price;
		}
		
		public void setCategory(Category category) {
			this.category=category;
		}
		public Category getCategory() {
			return category;
		}
}
