package com.cs491.vendar.dao;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import com.cs491.vendar.model.Product;
import com.cs491.vendar.model.User;

public interface UserDAO {
    
    int insertUser(UUID id, User user);

    default int insertUser(User user) {
        UUID id = UUID.randomUUID();
        return insertUser(id, user);
    }

    Optional<User> getUserById(UUID id);
    Optional<User> getUserByUsername(String Email);

    List<Product> getFavoritedProducts(String email);

    int addFavoritedProduct(String email, UUID productId);
    int removeFavoritedProduct(String email, UUID productId);

    int setPasswordByEmail(String email, String password);
    int setEmailByEmail(String email, String newEmail);
    int setPhoneByEmail(String email, String phone);

    int deleteUserByEmail(String email);

}
