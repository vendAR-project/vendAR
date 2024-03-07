package com.cs491.vendar.model;

import java.util.UUID;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class User {
    private UUID id;
    private String name;
    private String surname;
    private String password;
    private String email;
    private String phoneNumber;

    public User(
        @JsonProperty("user_id") UUID id,
        @JsonProperty("user_name") String name,
        @JsonProperty("user_surname") String surname,
        @JsonProperty("user_password") String password,
        @JsonProperty("user_email") String email,
        @JsonProperty("user_phone") String phoneNumber
    ) {
        setId(id);
        setName(name);
        setSurname(surname);
        setPassword(password);
        setEmail(email);
        setPhoneNumber(phoneNumber);
    }
}
