package com.cs491.vendar.service;

import java.util.Optional;
import java.util.UUID;

import org.springframework.stereotype.Service;

import com.cs491.vendar.dao.ModelDAO;
import com.cs491.vendar.model.Model;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ModelService {
    private final ModelDAO modelDAO;

    public int insertModel(Model model) 
    {
        return modelDAO.insertModel(model);
    }

    public Optional<Model> getModelById(UUID id) 
    {
        return modelDAO.getModelById(id);
    }
    
    public Optional<Model> getModelByProductId(UUID productId) 
    {
        return modelDAO.getModelByProductId(productId);
    }

    public int setDimensionsById(UUID id, float[] dimensions) 
    {
        return modelDAO.setDimensionsById(id, dimensions);
    }

    public int deleteModelById(UUID id) 
    {
        return modelDAO.deleteModelById(id);
    }
}
