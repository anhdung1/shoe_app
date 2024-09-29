package com.example.demo.service;

import java.security.SecureRandom;

public class OrderCodeGenerator {
	 private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	    private static final int LENGTH = 10;
	    private static final SecureRandom random = new SecureRandom();

	    public static String generateOrderCode() {
	        StringBuilder result = new StringBuilder();
	        while (result.length() < LENGTH) {
	            int index = random.nextInt(CHARACTERS.length());
	            char character = CHARACTERS.charAt(index);
	            if (result.indexOf(String.valueOf(character)) == -1) { 
	                result.append(character);
	            }
	        }
	        return result.toString();
	    }
}
