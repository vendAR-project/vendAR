package com.cs491.vendar.dao;

import java.util.Optional;
import java.util.UUID;

import com.cs491.vendar.model.Product;

public interface ProductDAO {
    
    int insertProduct(UUID id, Product product);

    default int insertProduct(Product product) {
        UUID id = UUID.randomUUID();
        return insertProduct(id, product);
    }

    Optional<Product> getProductById(UUID id);
}
