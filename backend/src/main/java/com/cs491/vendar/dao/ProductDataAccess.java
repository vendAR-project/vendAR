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

    private final JdbcTemplate jdbcTemplate;

    @Override
    public int insertProduct(UUID id, Product product) {
        final String sql = "INSERT INTO Product VALUES(?, ?, ?, ?, ?, ?, ?, ?)";

        int result = jdbcTemplate.update(sql, new Object[] { id, product.getUserId(), product.getTitle(), product.getDescription(),
                                    product.getPrice(), product.getImages(), product.getFeatures(), product.getSalesPageUrl() });

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
            String features = resultSet.getString("product_feature");
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
            String features = resultSet.getString("product_feature");
            String salesPageUrl = resultSet.getString("product_sales_page_url");

            UUID modelId = UUID.fromString(resultSet.getString("model_id"));
            Float[] dimensionsObj = (Float[]) resultSet.getArray("model_dimensions").getArray();
            float[] dimensions = new float[3];

            for (int in = 0; in < 3; in++) 
            {
                dimensions[in] = dimensionsObj[in];
            }
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
    public List<Product> getAllProducts() {
        final String sql = "SELECT * FROM Product";

        List<Product> products = jdbcTemplate.query(sql, (resultSet, i) -> {
            
            UUID productId = UUID.fromString(resultSet.getString("product_id"));
            UUID userId = UUID.fromString(resultSet.getString("user_id"));
            String title = resultSet.getString("product_title");
            String description = resultSet.getString("product_desc");
            float price = resultSet.getFloat("product_price");
            String[] images = (String[]) resultSet.getArray("product_images").getArray();
            String features = resultSet.getString("product_feature");
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
        });

        return products;
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
            String features = resultSet.getString("product_feature");
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

    @Override
    public List<ProductWithModel> getAllProductsWithModel() {
        final String sql = "SELECT p.*, m.* " +
                           "FROM Product p " +
                           "LEFT JOIN Model m ON p.product_id = m.product_id";

        List<ProductWithModel> productsWithModel = jdbcTemplate.query(sql, (resultSet, i) -> {
            UUID productId = UUID.fromString(resultSet.getString("product_id"));
            UUID userId = UUID.fromString(resultSet.getString("user_id"));
            String title = resultSet.getString("product_title");
            String description = resultSet.getString("product_desc");
            float price = resultSet.getFloat("product_price");
            String[] images = (String[]) resultSet.getArray("product_images").getArray();
            String features = resultSet.getString("product_feature");
            String salesPageUrl = resultSet.getString("product_sales_page_url");

            UUID modelId = UUID.fromString(resultSet.getString("model_id"));
            Float[] dimensionsObj = (Float[]) resultSet.getArray("model_dimensions").getArray();
            float[] dimensions = new float[3];

            for (int in = 0; in < 3; in++) 
            {
                dimensions[in] = dimensionsObj[in];
            }
            String src = resultSet.getString("model_src");
            
            Product product = new Product(
                productId,
                userId,
                title,
                description,
                price,
                images,
                features,
                salesPageUrl
            );

            Model model = new Model(modelId, productId, dimensions, src);

            return new ProductWithModel(product, model);
        });

        return productsWithModel;
    }

    @Override
    public int addImageById(UUID id, String imageId) {
        String sql = "SELECT product_images FROM Product WHERE product_id = ?";

        String[] images = jdbcTemplate.queryForObject(sql, (resultSet, i) -> {

            return (String[]) resultSet.getArray("product_images").getArray();

        }, new Object[] { id });

        String[] imagesNew = new String[images.length + 1];
        for (int i = 0; i < images.length; i++) {
            imagesNew[i] = images[i];
        }

        imagesNew[images.length] = imageId;

        sql = "UPDATE Product SET product_images = ? WHERE product_id = ?";

        return jdbcTemplate.update(sql, new Object[] { imagesNew, id });
    }

    @Override
    public int removeImageById(UUID id, String imageId) {
        String sql = "SELECT product_images FROM Product WHERE product_id = ?";

        String[] images = jdbcTemplate.queryForObject(sql, (resultSet, i) -> {

            return (String[]) resultSet.getArray("product_images").getArray();

        }, new Object[] { id });

        String[] imagesNew = new String[images.length - 1];
        int j = 0;

        for (int i = 0; i < images.length; i++) {
            if (!images[i].equals(imageId)) {
                imagesNew[j] = images[i];
                j++;
            }
        }

        sql = "UPDATE Product SET product_images = ? WHERE product_id = ?";

        return jdbcTemplate.update(sql, new Object[] { imagesNew, id });
    }

    @Override
    public int setTitleById(UUID id, String title) {
        final String sql = "UPDATE Product SET product_title = ? WHERE product_id = ?";

        return jdbcTemplate.update(sql, new Object[] { title, id });
    }

    @Override
    public int setDescriptionById(UUID id, String description) {
        final String sql = "UPDATE Product SET product_desc = ? WHERE product_id = ?";

        return jdbcTemplate.update(sql, new Object[] { description, id });
    }

    @Override
    public int setPriceById(UUID id, float price) {
        final String sql = "UPDATE Product SET product_price = ? WHERE product_id = ?";

        return jdbcTemplate.update(sql, new Object[] { price, id });
    }

    @Override
    public int setFeatureById(UUID id, String feature) {
        final String sql = "UPDATE Product SET product_feature = ? WHERE product_id = ?";

        return jdbcTemplate.update(sql, new Object[] { feature, id });
    }

    @Override
    public int setSalesPageUrlById(UUID id, String salesPageUrl) {
        final String sql = "UPDATE Product SET product_sales_page_url = ? WHERE product_id = ?";

        return jdbcTemplate.update(sql, new Object[] { salesPageUrl, id });
    }

    @Override
    public int deleteProductById(UUID id) {
        final String sql = "DELETE FROM Product WHERE product_id = ?";

        return jdbcTemplate.update(sql, new Object[] { id });
    }
}
