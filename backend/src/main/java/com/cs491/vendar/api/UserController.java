package com.cs491.vendar.api;

import java.util.UUID;

import com.cs491.vendar.model.User;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cs491.vendar.service.JwtService;
import com.cs491.vendar.service.UserService;

import lombok.RequiredArgsConstructor;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/user")
@RequiredArgsConstructor
public class UserController {
    
    private final UserService userService;
    private final JwtService jwtService;

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

    @GetMapping()
    public User getUserByEmail(@RequestHeader String authorization) 
    {    
        final String email = jwtService.extractName(authorization.substring(7));
        
        return userService.getUserByUsername(email).orElse(null);
    }

    @PutMapping(path = "password={password}")
    public int setPasswordById(@RequestHeader String authorization, @PathVariable("password") String password) 
    {
        final String email = jwtService.extractName(authorization.substring(7));

        return userService.setPasswordByEmail(email, password);
    }

    @PutMapping(path = "email={email}")
    public int setEmailById(@RequestHeader String authorization, @PathVariable("email") String newEmail) 
    {
        final String email = jwtService.extractName(authorization.substring(7));

        return userService.setEmailByEmail(email, newEmail);
    }
}