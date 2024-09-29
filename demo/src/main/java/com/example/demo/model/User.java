package com.example.demo.model;

import java.util.List;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;

@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "first_name")
    private String firstName;
    @Column(name = "maiden_name")
    private String maidenName;
    private String phone;
    private String  image;
    private String gender;
    private String username;
    private String password;
    private String email;
    private Long age;
    public User() {
    }
    public  User(String username,Set<Role> roles,String password) {
    	this.username=username;
    			this.roles=roles;
    			this.password=password;
    }
    @OneToMany(mappedBy="user",cascade=CascadeType.ALL)
    @JsonIgnore
    private List<Orders> orders;
    @OneToMany(mappedBy="user",cascade=CascadeType.ALL)
    @JsonIgnore
    private List<Cart> cart;
    @ManyToMany(fetch = FetchType.EAGER) 
    @JoinTable(
        name = "user_roles", // Tên bảng trung gian
        joinColumns = @JoinColumn(name = "user_id"), // Cột tham chiếu đến bảng users
        inverseJoinColumns = @JoinColumn(name = "role_id") // Cột tham chiếu đến bảng roles
    )
    private Set<Role> roles; 
    public List<Cart> getCart() {
        return cart;
    }

    public void setCart(List<Cart> cart) {
        this.cart = cart;
    }
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMaidenName() {
		return maidenName;
	}

	public void setMaidenName(String maidenName) {
		this.maidenName = maidenName;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public Long getAge() {
		return age;
	}

	public void setAge(Long age) {
		this.age = age;
	}
	public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }
}
