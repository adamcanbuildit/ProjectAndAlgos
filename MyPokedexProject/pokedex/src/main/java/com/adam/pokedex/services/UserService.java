package com.adam.pokedex.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

import com.adam.pokedex.models.*;
import com.adam.pokedex.repositories.*;

@Service
public class UserService {
	private final UserRepository userRepo;
	
	public UserService(UserRepository userRepo) {
        this.userRepo = userRepo;
    }
	
	// Register user and hash their password
    public User registerUser(User user) {
        String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashed);
        return userRepo.save(user);
    }
    
    // Return all users
    public List<User> getAllUsers() {
    	return userRepo.findAll();
    }
    
    // Find user by email
    public User findByEmail(String email) {
        return userRepo.findByEmail(email);
    }
    
    // Find user by id
    public User findUserById(Long id) {
    	Optional<User> u = userRepo.findById(id);
    	if(u.isPresent()) {
            return u.get();
    	} else {
    	    return null;
    	}
    }
    
    // Authenticate user
    // returns False is user doesn't exist OR if password doesn't match
    public boolean authenticateUser(String email, String password) {
        // first find the user by email
        User user = userRepo.findByEmail(email);
        // if we can't find it by email, return false
        if(user == null) {
            return false;
        } else {
            // if the passwords match, return true, else, return false
            if(BCrypt.checkpw(password, user.getPassword())) {
                return true;
            } else {
                return false;
            }
        }
    }

    // Like another user's pokedex
    public void likeAPokedexById(Long currentUserId,Long pokedexOwnerId) {
    	User currentUser = findUserById(currentUserId);
    	User pokedexOwner = findUserById(pokedexOwnerId);
    	if (currentUser.getLikes().contains(pokedexOwner)) {
    		currentUser.getLikes().remove(pokedexOwner);
    		userRepo.save(currentUser);
    	} else {
    		currentUser.getLikes().add(pokedexOwner);
    		userRepo.save(currentUser);
    	}
    }
}