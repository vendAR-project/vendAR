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
    private float price;
    private String[] images;
    private String features;
    private String salesPageUrl;
    private String src;


    public Product(
        @JsonProperty("product_id") UUID id,
        @JsonProperty("user_id") UUID userId,
        @JsonProperty("product_title") String title,
        @JsonProperty("product_desc") String description,
        @JsonProperty("product_price") float price,
        @JsonProperty("product_images") String[] images,
        @JsonProperty("product_feature") String features,
        @JsonProperty("product_sales_page_url") String salesPageUrl,
        @JsonProperty("product_src") String src
    ) {
        setId(id);
        setUserId(userId);
        setTitle(title);
        setDescription(description);
        setPrice(price);
        setImages(images);
        setFeatures(features);
        setSalesPageUrl(salesPageUrl);
        setSrc(src);
    }
}
