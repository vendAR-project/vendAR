package com.cs491.vendar.config;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.stereotype.Component;

import com.cs491.vendar.dao.TokenDAO;
import com.cs491.vendar.model.Token;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class CustomLogoutHandler implements LogoutHandler {

    private final TokenDAO tokenDAO;

    @Override
    public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
        
        String authHeader = request.getHeader("Authorization");

        if(authHeader == null || !authHeader.startsWith("Bearer ")) {
            return;
        }

        String token = authHeader.substring(7);
    
        Token storedToken = tokenDAO.findByToken(token).get();

        if(token != null) {
            storedToken.setLoggedOut(true);
            tokenDAO.updateSingleToken(storedToken.getId(), true);
        }
    }
    
}
