package com.example.demo.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.model.User;
import com.example.demo.repository.UserRepository;
@Service
public class UserService {
	  @Autowired
	    private UserRepository userRepository;

	    public boolean authenticateUser(String username, String password) {
	        User user = userRepository.findByUsername(username);
	        if (user != null && user.getPassword().equals(password)) {


	            userRepository.save(user);
	            return true;
	        }
	        return false;
	    }
	    public User getUserByUsername(String username) {
	        return userRepository.findByUsername(username);
	    }
	    public boolean check(User user) {
	    	User user1 = userRepository.findByUsername(user.getUsername());
	    	if(user1==null&&user.getUsername()!="") {
	    		
	    		return true;
	    	}
	    	return false;
	    }
	    public User saveUser(User user) {
	    	return userRepository.save(user);
	    }
}
