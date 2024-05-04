package com.cs491.vendar.api;

import java.util.List;
import java.util.UUID;

import com.cs491.vendar.model.Product;
import com.cs491.vendar.model.User;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
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

    @GetMapping(path = "fav")
    public List<Product> getFavoritedProducts(@RequestHeader String authorization) 
    {
        final String email = jwtService.extractName(authorization.substring(7));

        return userService.getFavoritedProducts(email);
    }

    @PutMapping(path = "a/id={id}")
    public int addFavoritedProduct(@RequestHeader String authorization, @PathVariable("id") UUID id) 
    {
        final String email = jwtService.extractName(authorization.substring(7));

        return userService.addFavoritedProduct(email, id);
    }

    @PutMapping(path = "r/id={id}")
    public int removeFavoritedProduct(@RequestHeader String authorization, @PathVariable("id") UUID id) 
    {
        final String email = jwtService.extractName(authorization.substring(7));

        return userService.removeFavoritedProduct(email, id);
    }

    @PutMapping(path = "password={password}")
    public int setPasswordByEmail(@RequestHeader String authorization, @PathVariable("password") String password) 
    {
        final String email = jwtService.extractName(authorization.substring(7));

        return userService.setPasswordByEmail(email, password);
    }

    @PutMapping(path = "email={email}")
    public int setEmailByEmail(@RequestHeader String authorization, @PathVariable("email") String newEmail) 
    {
        final String email = jwtService.extractName(authorization.substring(7));

        return userService.setEmailByEmail(email, newEmail);
    }

    @PutMapping(path = "phone={phone}")
    public int setPhoneByEmail(@RequestHeader String authorization, @PathVariable("phone") String phone) 
    {
        final String email = jwtService.extractName(authorization.substring(7));

        return userService.setPhoneByEmail(email, phone);
    }

    @DeleteMapping
    public int deleteUserByEmail(@RequestHeader String authorization) 
    {
        final String email = jwtService.extractName(authorization.substring(7));

        return userService.deleteUserByEmail(email);
    }
}
