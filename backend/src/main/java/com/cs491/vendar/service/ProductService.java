package com.cs491.vendar.service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.stereotype.Service;

import com.cs491.vendar.dao.ProductDAO;
import com.cs491.vendar.misc.ProductWithModel;
import com.cs491.vendar.model.Product;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProductService {
    private final ProductDAO productDAO;

    public int insertProduct(Product product) 
    {
        return productDAO.insertProduct(product);
    }

    public Optional<Product> getProductById(UUID id) 
    {
        return productDAO.getProductById(id);
    }

    public Optional<ProductWithModel> getProductWithModelById(UUID id) 
    {
        return productDAO.getProductWithModelById(id);
    }

    public List<Product> getAllProducts() 
    {
        return productDAO.getAllProducts();
    }
    
    public List<ProductWithModel> getAllProductsOfUser(UUID userId) 
    {
        return productDAO.getAllProductsWithModelOfUser(userId);
    }

    public List<ProductWithModel> getAllProductsWithModel() 
    {
        return productDAO.getAllProductsWithModel();
    }

    public int addImageById(UUID id, String imageId) 
    {
        return productDAO.addImageById(id, imageId);
    }

    public int removeImageById(UUID id, String imageId) 
    {
        return productDAO.removeImageById(id, imageId);
    }

    public int setTitleById(UUID id, String title) 
    {
        return productDAO.setTitleById(id, title);
    }

    public int setDescriptionById(UUID id, String description) 
    {
        return productDAO.setDescriptionById(id, description);
    }

    public int setPriceById(UUID id, float price) 
    {
        return productDAO.setPriceById(id, price);
    }

    public int setFeatureById(UUID id, String feature) 
    {
        return productDAO.setFeatureById(id, feature);
    }

    public int setSalesPageUrlById(UUID id, String salesPageUrl) 
    {
        return productDAO.setSalesPageUrlById(id, salesPageUrl);
    }

    public int deleteProductById(UUID id) 
    {
        return productDAO.deleteProductById(id);
    }
}
