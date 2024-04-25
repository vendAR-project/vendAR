package com.cs491.vendar.dao;

import java.util.Optional;
import java.util.UUID;

import com.cs491.vendar.model.Model;

public interface ModelDAO {
    
    int insertModel(UUID id, Model model);

    default int insertModel(Model model) {
        UUID id = UUID.randomUUID();
        return insertModel(id, model);
    }

    Optional<Model> getModelById(UUID id);
    Optional<Model> getModelByProductId(UUID productId); 

    int setDimensionsById(UUID id, float[] dimensions);
}
