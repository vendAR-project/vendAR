package com.cs491.vendar.dao;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import com.cs491.vendar.misc.ProductWithModel;
import com.cs491.vendar.model.Product;

public interface ProductDAO {
    
    int insertProduct(UUID id, Product product);

    default int insertProduct(Product product) {
        UUID id = UUID.randomUUID();
        return insertProduct(id, product);
    }

    Optional<Product> getProductById(UUID id);
    Optional<ProductWithModel> getProductWithModelById(UUID id);

    List<Product> getAllProducts();
    List<Product> getAllProductsOfUser(UUID userId);
    List<ProductWithModel> getAllProductsWithModel();

    int addImageById(UUID id, String imageId);
    int removeImageById(UUID id, String imageId);

    int setTitleById(UUID id, String title);
    int setDescriptionById(UUID id, String description);
    int setPriceById(UUID id, float price);
    int setFeatureById(UUID id, String feature);
    int setSalesPageUrlById(UUID id, String salesPageUrl);

    int deleteProductById(UUID id);
}
