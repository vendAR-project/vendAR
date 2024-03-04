package com.cs491.vendar.dao;

import java.util.Optional;
import java.util.UUID;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.cs491.vendar.model.User;

import lombok.RequiredArgsConstructor;

@Repository("Person")
@Transactional
@RequiredArgsConstructor
public class UserDataAccess implements UserDAO {

    private JdbcTemplate jdbcTemplate;

    @Override
    public int insertUser(UUID id, User user) {
        final String sql = "INSERT INTO Person VALUES(?, ?, ?, ?, ?, ?)";

        int result = jdbcTemplate.update(sql, new Object[] { id, user.getName(), user.getSurname(), user.getPassword(),
                                            user.getEmail(), user.getPhoneNumber() });

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
            String phoneNumber = resultSet.getString("user_phone_number");
            return new User(
                userId,
                name,
                surname,
                password,
                email,
                phoneNumber
            );
        }, new Object[] { id });
        return Optional.ofNullable(user);
    }
    
}
