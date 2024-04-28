package com.cs491.vendar.dao;

import java.util.Optional;
import java.util.UUID;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.cs491.vendar.model.Model;

import lombok.RequiredArgsConstructor;

@Repository("Model")
@Transactional
@RequiredArgsConstructor
public class ModelDataAccess implements ModelDAO {

    private final JdbcTemplate jdbcTemplate;

    @Override
    public int insertModel(UUID id, Model model) {
        final String sql = "INSERT INTO Model VALUES(?, ?, ?, ?)";

        int result = jdbcTemplate.update(sql, new Object[] { id, model.getProductId(), model.getModelDimensions(), model.getModelSrc() });
    
        return result;
    }

    @Override
    public Optional<Model> getModelById(UUID id) {
        final String sql = "SELECT * FROM Model where model_id = ?";

        Model model = jdbcTemplate.queryForObject(sql, (resultSet, i) -> {
            UUID productId = UUID.fromString(resultSet.getString("product_id"));
            Float[] dimensionsObj = (Float[]) resultSet.getArray("model_dimensions").getArray();
            float[] dimensions = new float[3];

            for (int in = 0; in < 3; in++) 
            {
                dimensions[in] = dimensionsObj[in];
            }
            
            String src = resultSet.getString("model_src");
            return new Model(
                id,
                productId,
                dimensions,
                src
            );
        }, new Object[] { id });
        return Optional.ofNullable(model);
    }

    @Override
    public Optional<Model> getModelByProductId(UUID productId) {
        final String sql = "SELECT * FROM Model where product_id = ?";

        Model model = jdbcTemplate.queryForObject(sql, (resultSet, i) -> {
            UUID id = UUID.fromString(resultSet.getString("model_id"));
            Float[] dimensionsObj = (Float[]) resultSet.getArray("model_dimensions").getArray();
            float[] dimensions = new float[3];

            for (int in = 0; in < 3; in++) 
            {
                dimensions[in] = dimensionsObj[in];
            }

            String src = resultSet.getString("model_src");
            return new Model(
                id,
                productId,
                dimensions,
                src
            );
        }, new Object[] { productId });
        return Optional.ofNullable(model);
    }

    @Override
    public int setDimensionsById(UUID id, float[] dimensions) {
        final String sql = "UPDATE Model SET model_dimensions = ? WHERE model_id = ?";

        return jdbcTemplate.update(sql, new Object[] { dimensions, id });
    }

    @Override
    public int deleteModelById(UUID id) {
        final String sql = "DELETE FROM Model WHERE model_id = ?";

        return jdbcTemplate.update(sql, new Object[] { id });
    }
}
