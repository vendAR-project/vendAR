package com.cs491.vendar.dao;

import java.util.Optional;
import java.util.UUID;

import com.cs491.vendar.model.User;

public interface UserDAO {
    
    int insertUser(UUID id, User user);

    default int insertUser(User user) {
        UUID id = UUID.randomUUID();
        return insertUser(id, user);
    }

    Optional<User> getUserById(UUID id);
    Optional<User> getUserByUsername(String Email);
}
