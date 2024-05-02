package com.cs491.vendar.api;

import java.util.List;
import java.util.UUID;

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

import com.cs491.vendar.misc.ProductWithModel;
import com.cs491.vendar.model.Product;
import com.cs491.vendar.service.JwtService;
import com.cs491.vendar.service.ProductService;

import lombok.RequiredArgsConstructor;


@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/product")
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;
    private final JwtService jwtService;

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

    @GetMapping(path = "m/id={id}")
    public ProductWithModel getProductWithModelById(@PathVariable("id") UUID id) 
    {
        return productService.getProductWithModelById(id).orElse(null);
    }

    @GetMapping
    public List<Product> getAllProducts() 
    {
        return productService.getAllProducts();
    }
    
    @GetMapping(path = "user")
    public List<ProductWithModel> getAllProductsOfUser(@RequestHeader String authorization) 
    {
        final String email = jwtService.extractName(authorization.substring(7));

        return productService.getAllProductsOfUser(email);
    }

    @GetMapping(path = "m")
    public List<ProductWithModel> getAllProductsWithModel() {
        return productService.getAllProductsWithModel();
    }

    @GetMapping(path = "r")
    public List<ProductWithModel> getRecommendedProducts() {
        return productService.getRecommendedProducts();
    }
    
    @PutMapping(path = "a/id={id}/image={image}")
    public int addImageById(@PathVariable("id") UUID id, @PathVariable("image") String image) 
    {
        return productService.addImageById(id, image);
    } 

    @PutMapping(path = "r/id={id}/image={image}")
    public int removeImageById(@PathVariable("id") UUID id, @PathVariable("image") String image) 
    {
        return productService.removeImageById(id, image);
    } 

    @PutMapping(path = "id={id}/title={title}")
    public int setTitleById(@PathVariable("id") UUID id, @PathVariable("title") String title) 
    {
        return productService.setTitleById(id, title);
    } 
    
    @PutMapping(path = "id={id}/desc={desc}")
    public int setDescriptionById(@PathVariable("id") UUID id, @PathVariable("desc") String description) 
    {
        return productService.setDescriptionById(id, description);
    } 

    @PutMapping(path = "id={id}/price={price}")
    public int setPriceById(@PathVariable("id") UUID id, @PathVariable("price") float price) 
    {
        return productService.setPriceById(id, price);
    } 

    @PutMapping(path = "id={id}/feature={feature}")
    public int setFeatureById(@PathVariable("id") UUID id, @PathVariable("feature") String feature) 
    {
        return productService.setFeatureById(id, feature);
    }

    @PutMapping(path = "id={id}/spu={spu}")
    public int setSalesPageUrlById(@PathVariable("id") UUID id, @PathVariable("spu") String salesPageUrl) 
    {
        return productService.setSalesPageUrlById(id, salesPageUrl);
    } 

    @DeleteMapping(path = "id={id}")
    public int deleteProductById(@PathVariable("id") UUID id) 
    {
        return productService.deleteProductById(id);
    }
}
