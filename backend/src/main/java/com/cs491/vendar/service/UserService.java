package com.cs491.vendar.service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.cs491.vendar.dao.UserDAO;
import com.cs491.vendar.model.Product;
import com.cs491.vendar.model.User;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService implements UserDetailsService {
    private final UserDAO userDAO;

    public int insertUser(User user) 
    {
        return userDAO.insertUser(user);
    }

    public Optional<User> getUserById(UUID id) 
    {
        return userDAO.getUserById(id);
    }

    public Optional<User> getUserByUsername(String email)
    {
        return userDAO.getUserByUsername(email);
    }

    public List<Product> getFavoritedProducts(String email) 
    {
        return userDAO.getFavoritedProducts(email);
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        return userDAO.getUserByUsername(email).get();
    }

    public int addFavoritedProduct(String email, UUID id) 
    {
        return userDAO.addFavoritedProduct(email, id);
    }

    public int removeFavoritedProduct(String email, UUID id) 
    {
        return userDAO.removeFavoritedProduct(email, id);
    }

    public int setPasswordByEmail(String email, String password) 
    {
        return userDAO.setPasswordByEmail(email, password);
    }

    public int setEmailByEmail(String email, String newEmail) 
    {
        return userDAO.setEmailByEmail(email, newEmail);
    }

    public int setPhoneByEmail(String email, String phone) 
    {
        return userDAO.setPhoneByEmail(email, phone);
    }

    public int deleteUserByEmail(String email) 
    {
        return userDAO.deleteUserByEmail(email);
    }
}
