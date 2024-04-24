package com.cs491.vendar.dao;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import com.cs491.vendar.model.Token;

public interface TokenDAO {
    int insertToken(Token token);

    Optional<Token> findByToken(String token);

    List<Token> getAllTokensOfUser(UUID userId);

    int updateAllUserTokens(UUID userId, boolean isLoggedOut);

    int updateSingleToken(int tokenId, boolean isLoggedOut);
}
