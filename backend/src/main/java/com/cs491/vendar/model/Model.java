package com.cs491.vendar.model;

import java.util.UUID;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class Model {
    private UUID id;
    private UUID productId;
    private float[] modelDimensions;
    private String modelSrc;

    public Model(
        @JsonProperty("model_id") UUID id,
        @JsonProperty("product_id") UUID productId,
        @JsonProperty("model_dimensions") float[] modelDimensions,
        @JsonProperty("model_src") String modelSrc
    ) {
        setId(id);
        setProductId(productId);
        setModelDimensions(modelDimensions);
        setModelSrc(modelSrc);
    }
}
