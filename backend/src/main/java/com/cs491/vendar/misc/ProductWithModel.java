package com.cs491.vendar.misc;

import com.cs491.vendar.model.Model;
import com.cs491.vendar.model.Product;

import lombok.Data;

@Data
public class ProductWithModel {
    private Product product;
    private Model model;

    public ProductWithModel(Product product, Model model) { 
        this.product = product;
        this.model = model;
    }
}
