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

    @GetMapping(path = "m/id={id}")
    public Product getProductWithModelById(@PathVariable("id") UUID id) 
    {
        return productService.getProductWithModelById(id).orElse(null);
    }

    @GetMapping
    public List<Product> getAllProducts() 
    {
        return productService.getAllProducts();
    }
    
    @GetMapping(path = "userId={userId}")
    public List<Product> getAllProductsOfUser(@PathVariable("userId") UUID userId) 
    {
        return productService.getAllProductsOfUser(userId);
    }

    @GetMapping(path = "m")
    public List<Product> getAllProductsWithModel() {
        return productService.getAllProductsWithModel();
    }

    @GetMapping(path = "r")
    public List<Product> getRecommendedProducts() {
        return productService.getRecommendedProducts();
    }
    
    @PutMapping(path = "a/id={id}/image={image}")
    public int addImageById(@PathVariable("id") UUID id, @PathVariable("image") String image) 
    {
        String imageHttps = "https://" + image;

        imageHttps = imageHttps.replace("<>", "/");

        return productService.addImageById(id, imageHttps);
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
        String salesPageUrlHttps = "https://" + salesPageUrl;

        salesPageUrlHttps = salesPageUrlHttps.replace("<>", "/");

        return productService.setSalesPageUrlById(id, salesPageUrlHttps);
    } 

    @PutMapping(path = "id={id}/src={src}")
    public int setSrcById(@PathVariable("id") UUID id, @PathVariable("src") String src) 
    {
        String srcHttps = "https://" + src;

        srcHttps = srcHttps.replace("<>", "/");

        return productService.setSrcById(id, srcHttps);
    }

    @DeleteMapping(path = "id={id}")
    public int deleteProductById(@PathVariable("id") UUID id) 
    {
        return productService.deleteProductById(id);
    }
}
