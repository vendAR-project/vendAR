package com.cs491.vendar.dao;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.cs491.vendar.model.User;
import com.cs491.vendar.model.Role;

import lombok.RequiredArgsConstructor;

@Repository("Person")
@Transactional
@RequiredArgsConstructor
public class UserDataAccess implements UserDAO {

    private final JdbcTemplate jdbcTemplate;

    @Override
    public int insertUser(UUID id, User user) {
        final String sql = "INSERT INTO Person VALUES(?, ?, ?, ?, ?, ?, ?)";
        
        int result = jdbcTemplate.update(sql, new Object[] { id, user.getName(), user.getSurname(), user.getPassword(),
                                            user.getEmail(), user.getPhoneNumber(), user.getRole().toString() });

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
            String role_s = resultSet.getString("user_role");
            Role role = Role.valueOf(role_s);
            return new User(
                userId,
                name,
                surname,
                password,
                email,
                phoneNumber,
                role
            );
        }, new Object[] { id });
        return Optional.ofNullable(user);
    }
    
    @Override
    public Optional<User> getUserByUsername(String Email)
    {
        final String sql = "SELECT * FROM Person WHERE user_email = ?";

        List<User> users = jdbcTemplate.query(sql, (resultSet, i) -> {
            UUID userId = UUID.fromString(resultSet.getString("user_id"));
            String name = resultSet.getString("user_name");
            String surname = resultSet.getString("user_surname");
            String password = resultSet.getString("user_password");
            String email = resultSet.getString("user_email");
            String phoneNumber = resultSet.getString("user_phone");
            String role_s = resultSet.getString("user_role");
            Role role = Role.valueOf(role_s);
            return new User(
                userId,
                name,
                surname,
                password,
                email,
                phoneNumber,
                role
            );
        }, new Object[] { Email });

        if(users.isEmpty()){
            return Optional.empty();
        }
        return Optional.ofNullable(users.get(0));
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
}
