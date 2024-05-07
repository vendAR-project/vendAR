package com.cs491.vendar.model;

import java.util.UUID;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class Token {
    private int id;
    private UUID userId;
    private String token;
    private boolean isLoggedOut;


    public Token(
        @JsonProperty("token_id") int id,
        @JsonProperty("user_id") UUID userId,
        @JsonProperty("token") String token,
        @JsonProperty("is_logged_out") boolean isLoggedOut
    ) {
        setId(id);
        setUserId(userId);
        setToken(token);
        setLoggedOut(isLoggedOut);
    }

    public Token() {

    }

    
}