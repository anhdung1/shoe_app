package com.example.demo.model;

public class CartDto {
    private String productTitle;
    private float productPrice;
    private String username;
    private String productImage;
    private Long quantity;
    private Long productId;
    // Constructors
    public CartDto(String productTitle, float productPrice, String username, String productImage,Long quantity,Long productId) {
        this.productTitle = productTitle;
        this.productPrice = productPrice;
        this.username = username;
        this.productImage=productImage;
        this.quantity=quantity;
        this.productId=productId;
    }

    // Getters and Setters
    public String getProductTitle() {
        return productTitle;
    }

    public void setProductTitle(String productTitle) {
        this.productTitle = productTitle;
    }

    public float getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(float productPrice) {
        this.productPrice = productPrice;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

	public String getProductImage() {
		return productImage;
	}

	public void setProductImage(String productPrice) {
		this.productImage = productPrice;
	}

	public Long getQuantity() {
		return quantity;
	}

	public void setQuantity(Long quantity) {
		this.quantity = quantity;
	}

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}
}
