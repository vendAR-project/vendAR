package com.cs491.vendar.service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.stereotype.Service;

import com.cs491.vendar.dao.TokenDAO;
import com.cs491.vendar.model.Token;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TokenService {
    private final TokenDAO tokenDAO;

    public int insertToken(Token token) 
    {
        return tokenDAO.insertToken(token);
    }

    public Optional<Token> findByToken(String token) 
    {
        return tokenDAO.findByToken(token);
    }
    
    public List<Token> getAllTokensOfUser(UUID userId) 
    {
        return tokenDAO.getAllTokensOfUser(userId);
    }
}