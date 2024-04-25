package com.cs491.vendar.api;

import java.util.UUID;

import com.cs491.vendar.model.User;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cs491.vendar.service.UserService;

import lombok.RequiredArgsConstructor;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/user")
@RequiredArgsConstructor
public class UserController {
    
    private final UserService userService;

    @PostMapping
    public int insertUser(@RequestBody User user) 
    {
        return userService.insertUser(user);
    }

    @GetMapping(path = "id={id}")
    public User getUserById(@PathVariable("id") UUID id) 
    {
        return userService.getUserById(id).orElse(null);
    }

    @PutMapping(path = "id={id}/password={password}")
    public int setPasswordById(@PathVariable("id") UUID id, @PathVariable("password") String password) 
    {
        return userService.setPasswordById(id, password);
    }

    @PutMapping(path = "id={id}/email={email}")
    public int setPasswordById(@PathVariable("id") UUID id, @PathVariable("email") String email) 
    {
        return userService.setPasswordById(id, email);
    }
}
