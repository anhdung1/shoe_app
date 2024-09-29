package com.example.demo.model;

public class OrderItemsRequestDTO {
	  private String productTitle;
	    private float productPrice;
	    private String productImage;

	    public OrderItemsRequestDTO(String productTitle, float productPrice, String productImage) {
	        this.productTitle = productTitle;
	        this.productPrice = productPrice;
	        this.productImage=productImage;
	    }

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


		public String getProductImage() {
			return productImage;
		}

		public void setProductImage(String productPrice) {
			this.productImage = productPrice;
		}




}