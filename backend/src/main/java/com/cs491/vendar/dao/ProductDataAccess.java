package com.cs491.vendar.dao;

import java.util.Optional;
import java.util.UUID;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.cs491.vendar.model.Product;

import lombok.RequiredArgsConstructor;

@Repository("Product")
@Transactional
@RequiredArgsConstructor
public class ProductDataAccess implements ProductDAO {

    private JdbcTemplate jdbcTemplate;

    @Override
    public int insertProduct(UUID id, Product product) {
        final String sql = "INSERT INTO Product VALUES(?, ?, ?, ?, ?, ?)";

        int result = jdbcTemplate.update(sql, new Object[] { id, product.getUserId(), product.getTitle(), product.getDescription(),
                                    product.getImages(), product.getFeatures() });

        return result;
    }

    @Override
    public Optional<Product> getProductById(UUID id) {
        final String sql = "SELECT * FROM Product WHERE product_id = ?";

        Product product = jdbcTemplate.queryForObject(sql, (resultSet, i) -> {
            UUID productId = UUID.fromString(resultSet.getString("product_id"));
            UUID userId = UUID.fromString(resultSet.getString("user_id"));
            String title = resultSet.getString("product_title");
            String description = resultSet.getString("product_desc");
            String[] images = (String[]) resultSet.getArray("product_images").getArray();
            String[] features = (String[]) resultSet.getArray("product_features").getArray();
            return new Product(
                productId,
                userId,
                title,
                description,
                images,
                features
            );
        }, new Object[] { id });

        return Optional.ofNullable(product);
    }
    
}
