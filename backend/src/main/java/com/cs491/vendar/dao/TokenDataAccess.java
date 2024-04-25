package com.cs491.vendar.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.cs491.vendar.model.Token;

import lombok.RequiredArgsConstructor;

@Repository("Token")
@Transactional
@RequiredArgsConstructor
public class TokenDataAccess implements TokenDAO {
    
    private final JdbcTemplate jdbcTemplate;
    
    @Override
    public int insertToken(Token token) {
        final String sql = "INSERT INTO Token (user_id, token, is_logged_out) VALUES (?, ?, ?)";

        int result = jdbcTemplate.update(sql, token.getUserId(), token.getToken(), token.isLoggedOut());

        return result;
    }

    @Override
    public Optional<Token> findByToken(String token) {
        final String sql = "SELECT * FROM Token WHERE token = ?";

        return Optional.of(jdbcTemplate.queryForObject(sql, new TokenRowMapper(), token));
    }

    @Override
    public List<Token> getAllTokensOfUser(UUID userId) {
        final String sql = "SELECT * FROM Token WHERE user_id = ?";
        return jdbcTemplate.queryForList(sql, Token.class, userId);
    }

    @Override
    public int updateAllUserTokens(UUID userId, boolean isLoggedOut) {
        final String sql = "UPDATE Token SET is_logged_out = ? WHERE user_id = ?";
        return jdbcTemplate.update(sql, isLoggedOut, userId);
    }

    @Override
    public int updateSingleToken(int tokenId, boolean isLoggedOut) {
        final String sql = "UPDATE Token SET is_logged_out = ? WHERE token_id = ?";
        return jdbcTemplate.update(sql, isLoggedOut, tokenId);
    }
    
    private static class TokenRowMapper implements RowMapper<Token> {
        @Override
        public Token mapRow(ResultSet rs, int rowNum) throws SQLException {
            Token token = new Token();
            token.setId(rs.getInt("token_id"));
            token.setToken(rs.getString("token"));
            token.setLoggedOut(rs.getBoolean("is_logged_out"));
            token.setUserId((UUID)rs.getObject("user_id"));
            return token;
        }
    }
    
}
