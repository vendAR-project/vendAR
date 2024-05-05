package com.cs491.vendar.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.cs491.vendar.model.User;
import com.cs491.vendar.model.Product;
import com.cs491.vendar.model.Role;

import lombok.RequiredArgsConstructor;

@Repository("Person")
@Transactional
@RequiredArgsConstructor
public class UserDataAccess implements UserDAO {

    private final JdbcTemplate jdbcTemplate;
    private final ProductDataAccess productDataAccess;

    @Override
    public int insertUser(UUID id, User user) {
        final String sql = "INSERT INTO Person VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
        
        int result = jdbcTemplate.update(sql, new Object[] { id, user.getName(), user.getSurname(), user.getPassword(),
                                            user.getEmail(), user.getPhoneNumber(), user.getFavoritedProducts(), user.getRole().toString() });

        return result;
    }

    @Override
    public Optional<User> getUserById(UUID id) {
        final String sql = "SELECT * FROM Person WHERE user_id = ?";

        User user = jdbcTemplate.queryForObject(sql, (resultSet, i) -> {
            UUID userId = UUID.fromString(resultSet.getString("user_id"));
            String name = resultSet.getString("user_name");
            String surname = resultSet.getString("user_surname");
            String password = resultSet.getString("user_password");
            String email = resultSet.getString("user_email");
            String phoneNumber = resultSet.getString("user_phone");
            UUID[] favoritedProducts = (UUID[]) resultSet.getArray("user_favorited_products").getArray();
            String role_s = resultSet.getString("user_role");
            Role role = Role.valueOf(role_s);
            return new User(
                userId,
                name,
                surname,
                password,
                email,
                phoneNumber,
                favoritedProducts,
                role
            );
        }, new Object[] { id });
        return Optional.ofNullable(user);
    }
    
    @Override
    public Optional<User> getUserByUsername(String Email)
    {
        final String sql = "SELECT * FROM Person WHERE user_email = ?";

        List<User> user = jdbcTemplate.query(sql, (resultSet, i) -> {
            UUID userId = UUID.fromString(resultSet.getString("user_id"));
            String name = resultSet.getString("user_name");
            String surname = resultSet.getString("user_surname");
            String password = resultSet.getString("user_password");
            String email = resultSet.getString("user_email");
            String phoneNumber = resultSet.getString("user_phone");
            UUID[] favoritedProducts = (UUID[]) resultSet.getArray("user_favorited_products").getArray();
            String role_s = resultSet.getString("user_role");
            Role role = Role.valueOf(role_s);
            return new User(
                userId,
                name,
                surname,
                password,
                email,
                phoneNumber,
                favoritedProducts,
                role
            );
        }, new Object[] { Email });

        if (user.size() == 0) {
            return Optional.empty();
        }

        return Optional.ofNullable(user.get(0));
    }

    @Override
    public List<Product> getFavoritedProducts(String email) {
        String sql = "SELECT user_favorited_products FROM Person WHERE user_email = ?";

        UUID[] favoriteProductIds = jdbcTemplate.queryForObject(sql, (resultSet, i) -> {
            return (UUID[]) resultSet.getArray("user_favorited_products").getArray();
        }, new Object[] { email });

        List<Product> favoritedProducts = new ArrayList<>();

        for (UUID productId : favoriteProductIds) {
            favoritedProducts.add(productDataAccess.getProductWithModelById(productId).orElse(null));
        }

        return favoritedProducts;
    }

    @Override
    public int addFavoritedProduct(String email, UUID productId) {
        String sql = "SELECT user_favorited_products FROM Person WHERE user_email = ?";

        UUID[] favoritedProducts = jdbcTemplate.queryForObject(sql, (resultSet, i) -> {

            return (UUID[]) resultSet.getArray("user_favorited_products").getArray();

        }, new Object[] { email });

        UUID[] favoritedProductsNew = new UUID[favoritedProducts.length + 1];
        for (int i = 0; i < favoritedProducts.length; i++) {
            favoritedProductsNew[i] = favoritedProducts[i];
        }

        favoritedProductsNew[favoritedProducts.length] = productId;

        sql = "UPDATE Person SET user_favorited_products = ? WHERE user_email = ?";

        return jdbcTemplate.update(sql, new Object[] { favoritedProductsNew, email });
    }
    
    @Override
    public int removeFavoritedProduct(String email, UUID productId) {
        String sql = "SELECT user_favorited_products FROM Person WHERE user_email = ?";

        UUID[] favoritedProducts = jdbcTemplate.queryForObject(sql, (resultSet, i) -> {

            return (UUID[]) resultSet.getArray("user_favorited_products").getArray();

        }, new Object[] { email });

        UUID[] favoritedProductsNew = new UUID[favoritedProducts.length - 1];
        int j = 0;
        
        for (int i = 0; i < favoritedProducts.length; i++) {
            if (!favoritedProducts[i].equals(productId)) {
                favoritedProductsNew[j] = favoritedProducts[i];
                j++;
            }
        }

        sql = "UPDATE Person SET user_favorited_products = ? WHERE user_email = ?";

        return jdbcTemplate.update(sql, new Object[] { favoritedProductsNew, email });
    }

    @Override
    public int setPasswordByEmail(String email, String password) {
        final String sql = "UPDATE Person SET user_password = ? WHERE user_email = ?";

        return jdbcTemplate.update(sql, new Object[] { password, email });
    }

    @Override
    public int setEmailByEmail(String email, String newEmail) {
        final String sql = "UPDATE Person SET user_email = ? WHERE user_email = ?";

        return jdbcTemplate.update(sql, new Object[] { newEmail, email });
    }

    @Override
    public int setPhoneByEmail(String email, String phone) {
        final String sql = "UPDATE Person SET user_phone = ? WHERE user_email = ?";

        return jdbcTemplate.update(sql, new Object[] { phone, email });
    }

    @Override
    public int deleteUserByEmail(String email) {
        final String sql = "DELETE FROM Person WHERE user_email = ?";

        return jdbcTemplate.update(sql, new Object[] { email });
    }

}
