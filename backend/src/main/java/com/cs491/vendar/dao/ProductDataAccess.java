package com.cs491.vendar.dao;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.cs491.vendar.misc.ProductWithModel;
import com.cs491.vendar.model.Model;
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
            UUID userId = UUID.fromString(resultSet.getString("user_id"));
            String title = resultSet.getString("product_title");
            String description = resultSet.getString("product_desc");
            float price = resultSet.getFloat("product_price");
            String[] images = (String[]) resultSet.getArray("product_images").getArray();
            String[] features = (String[]) resultSet.getArray("product_features").getArray();
            String salesPageUrl = resultSet.getString("product_sales_page_url");
            return new Product(
                id,
                userId,
                title,
                description,
                price,
                images,
                features,
                salesPageUrl
            );
        }, new Object[] { id });

        return Optional.ofNullable(product);
    }

    @Override
    public Optional<ProductWithModel> getProductWithModelById(UUID id) {
        final String sql = "SELECT p.*, m.* " +
                           "FROM Product p " +
                           "LEFT JOIN Model m ON p.product_id = m.product_id " +
                           "WHERE p.product_id = ?";

        ProductWithModel productWithModel = jdbcTemplate.queryForObject(sql, (resultSet, i) -> {
            UUID userId = UUID.fromString(resultSet.getString("user_id"));
            String title = resultSet.getString("product_title");
            String description = resultSet.getString("product_desc");
            float price = resultSet.getFloat("product_price");
            String[] images = (String[]) resultSet.getArray("product_images").getArray();
            String[] features = (String[]) resultSet.getArray("product_features").getArray();
            String salesPageUrl = resultSet.getString("product_sales_page_url");

            UUID modelId = UUID.fromString(resultSet.getString("model_id"));
            float[] dimensions = (float[]) resultSet.getArray("model_dimensions").getArray();
            String src = resultSet.getString("model_src");
            
            Product product = new Product(
                id,
                userId,
                title,
                description,
                price,
                images,
                features,
                salesPageUrl
            );

            Model model = new Model(modelId, id, dimensions, src);

            return new ProductWithModel(product, model);

        }, new Object[] { id });

        return Optional.ofNullable(productWithModel);
    }

    @Override
    public List<Product> getAllProductsOfUser(UUID userId) {
        final String sql = "SELECT * FROM Product WHERE user_id = ?";

        List<Product> products = jdbcTemplate.query(sql, (resultSet, i) -> {
            
            UUID productId = UUID.fromString(resultSet.getString("product_id"));
            String title = resultSet.getString("product_title");
            String description = resultSet.getString("product_desc");
            float price = resultSet.getFloat("product_price");
            String[] images = (String[]) resultSet.getArray("product_images").getArray();
            String[] features = (String[]) resultSet.getArray("product_features").getArray();
            String salesPageUrl = resultSet.getString("product_sales_page_url");
            return new Product(
                productId,
                userId,
                title,
                description,
                price,
                images,
                features,
                salesPageUrl
            );
        }, new Object[] { userId });

        return products;
    }
    
}
