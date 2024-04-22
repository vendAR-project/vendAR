package com.cs491.vendar.api;

import java.util.List;
import java.util.UUID;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cs491.vendar.model.Product;
import com.cs491.vendar.service.ProductService;

import lombok.RequiredArgsConstructor;


@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/product")
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;

    @PostMapping
    public int insertProduct(@RequestBody Product product) 
    {
        return productService.insertProduct(product);
    }

    @GetMapping(path = "id={id}")
    public Product getProductById(@PathVariable("id") UUID id) 
    {
        return productService.getProductById(id).orElse(null);
    }
    
    @GetMapping(path = "userId={userId}")
    public List<Product> getAllProductsOfUser(@PathVariable("userId") UUID userId) 
    {
        return productService.getAllProductsOfUser(userId);
    }
    
}
