package com.cs491.vendar.model;

import java.util.UUID;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class Product {
    private UUID id;
    private UUID userId;
    private String title;
    private String description;
    private String[] images;
    private String[] features;

    public Product(
        @JsonProperty("product_id") UUID id,
        @JsonProperty("user_id") UUID userId,
        @JsonProperty("product_title") String title,
        @JsonProperty("product_desc") String description,
        @JsonProperty("product_images") String[] images,
        @JsonProperty("product_features") String[] features
    ) {
        setId(id);
        setUserId(userId);
        setTitle(title);
        setDescription(description);
        setImages(images);
        setFeatures(features);
    }
}
