package com.example.demo.controller;
import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.demo.model.Role;
import com.example.demo.model.User;
import com.example.demo.service.LoginRequest;
import com.example.demo.service.UserService;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
    
    @Autowired
    private UserService userService;
    

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest loginRequest) {
        boolean isAuthenticated = userService.authenticateUser(loginRequest.getUsername(), loginRequest.getPassword());
        if (isAuthenticated) {User user = userService.getUserByUsername(loginRequest.getUsername());
            return ResponseEntity.ok(user);
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Account information or password is incorrect");
        }
    }
    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody User userRegister){
    	boolean isDuplicateUsername = userService.check(userRegister);
    	
    	if(isDuplicateUsername) {
    		Role role=new Role();
    		role.setName("USER");
    		Set<Role>roles=new HashSet<>();
    		userRegister.setRoles(roles);
    		userService.saveUser(userRegister);
    		return ResponseEntity.status(HttpStatus.CREATED).body("User registered successfully");
    	}
    	return ResponseEntity.status(HttpStatus.CONFLICT).body("Account name already exists");
    	
    }

}