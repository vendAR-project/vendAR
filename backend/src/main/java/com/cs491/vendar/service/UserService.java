package com.cs491.vendar.service;

import java.util.Optional;
import java.util.UUID;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.cs491.vendar.dao.UserDAO;
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

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        return userDAO.getUserByUsername(email).get();
    }

    public int setPasswordById(UUID id, String password) 
    {
        return userDAO.setPasswordById(id, password);
    }

    public int setEmailById(UUID id, String email) 
    {
        return userDAO.setEmailById(id, email);
    }
}
