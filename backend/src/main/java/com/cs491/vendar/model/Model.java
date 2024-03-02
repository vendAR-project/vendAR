package com.cs491.vendar.model;

import java.util.UUID;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class Model {
    private UUID id;
    private UUID product_id;
    private float[] model_dimensions;
    private String model_src;

    public Model(
        @JsonProperty("model_id") UUID id,
        @JsonProperty("product_id") UUID product_id,
        @JsonProperty("model_dimensions") float[] model_dimensions,
        @JsonProperty("model_src") String model_src
    ) {
        setId(product_id);
        setProduct_id(product_id);
        setModel_dimensions(model_dimensions);
        setModel_src(model_src);
    }
}
