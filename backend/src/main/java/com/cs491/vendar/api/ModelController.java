package com.cs491.vendar.api;

import java.util.UUID;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.cs491.vendar.dao.ModelDAO;
import com.cs491.vendar.model.Model;

import lombok.RequiredArgsConstructor;

import org.springframework.web.bind.annotation.RequestMapping;


@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/model")
@RequiredArgsConstructor
public class ModelController {

    private final ModelDAO modelService;

    @PostMapping
    public int insertModel(@RequestBody Model model) 
    {
        return modelService.insertModel(model);
    }

    @GetMapping(path = "id={id}")
    public Model getModelById(@PathVariable("id") UUID id) 
    {
        return modelService.getModelById(id).orElse(null);
    }

    @GetMapping(path = "productId={productId}")
    public Model getModelByProductId(@PathVariable("productId") UUID productId) 
    {
        return modelService.getModelByProductId(productId).orElse(null);
    }

    @PutMapping(path = "id={id}/dimensions={dimensions}")
    public int setDimensionsById(@PathVariable("id") UUID id, @PathVariable("dimensions") String dimensionsString) 
    {
        String[] dimensionsStringArray = dimensionsString.split(",");
        float[] dimensions = new float[dimensionsStringArray.length];
        for (int i = 0; i < dimensionsStringArray.length; i++) 
        {
            dimensions[i] = Float.parseFloat(dimensionsStringArray[i]);
        }

        return modelService.setDimensionsById(id, dimensions);
    }
}
