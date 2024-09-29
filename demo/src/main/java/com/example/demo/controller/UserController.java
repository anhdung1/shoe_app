package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.model.ChangePassword;
import com.example.demo.model.UpdateUser;
import com.example.demo.model.User;
import com.example.demo.repository.UserRepository;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @PutMapping("/edit/{id}")
    public ResponseEntity<User> updateUser(@RequestBody UpdateUser request, @PathVariable Long id) {
        if (userRepository.existsById(id)) {
        	
        	User user = userRepository.findById(id).orElseThrow();
        	System.out.println("User before update: " + user);
        	if (request.getFirstName() != null) {
                user.setFirstName(request.getFirstName());
            }
            if (request.getMaidenName() != null) {
                user.setMaidenName(request.getMaidenName());
            }
            if (request.getPhone() != null) {
                user.setPhone(request.getPhone());
            }
            if (request.getEmail() != null) {
                user.setEmail(request.getEmail());
            }
            if (request.getImage() != null) {
                user.setImage(request.getImage());
            }
            if (request.getGender() != null) {
                user.setGender(request.getGender());
            }
            if(request.getAge()!=null) {
            	user.setAge(request.getAge());
            }
            User updatedUser = userRepository.save(user);
            System.out.println("User after update: " + updatedUser);
            return ResponseEntity.ok(updatedUser);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    @PutMapping("/edit/{id}/password")
    public ResponseEntity<String> changePassword(@RequestBody ChangePassword request, @PathVariable Long id){
    	if(userRepository.existsById(id)) {
    	
    		User user=userRepository.findById(id).orElseThrow();
    		
    		if(request.getPassword().equals(user.getPassword())&&request.getNewPassword()!=null) {
    		user.setPassword(request.getNewPassword());
    		userRepository.save(user);
    			return ResponseEntity.ok("Changed password successfully");
    		}else if(!request.getPassword().equals(user.getPassword())) {
    			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body("Wrong password");
    		}else {
    			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body("New password is null");
    		}
    		
    	}
    	return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body("ID do not exists");
    }
   
    @GetMapping("/getUser")
    public List<User> getUser(){
    	return userRepository.findAll(); 
    }
   
}
