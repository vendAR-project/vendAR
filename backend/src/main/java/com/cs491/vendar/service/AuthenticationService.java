package com.cs491.vendar.service;

import java.nio.file.AccessDeniedException;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.cs491.vendar.dao.TokenDAO;
import com.cs491.vendar.dao.UserDAO;
import com.cs491.vendar.model.Token;
import com.cs491.vendar.model.User;
import com.cs491.vendar.responses.AuthenticationResponse;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AuthenticationService {

    private final UserDAO userDAO;
    private final TokenDAO tokenDAO;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;
    
    public AuthenticationResponse register(User request) throws AccessDeniedException {
        User user = new User();
        user.setName(request.getName());
        user.setSurname(request.getSurname());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setEmail(request.getEmail());
        user.setPhoneNumber(request.getPhoneNumber());
        user.setRole(request.getRole());
        
        if(userDAO.getUserByUsername(request.getEmail()).isPresent()){
            throw new AccessDeniedException("User with email " + request.getEmail() + " exists.");
        }

        userDAO.insertUser(user);

        String jwt = jwtService.generateToken(user);

        // Save the token
        insertToken(user, jwt);

        return new AuthenticationResponse(jwt);
    }

    

    public AuthenticationResponse authenticate(User request) {
        authenticationManager.authenticate(
            new UsernamePasswordAuthenticationToken(request.getUsername(), request.getPassword())
        );

        User user = userDAO.getUserByUsername(request.getUsername()).orElseThrow();
        String jwt = jwtService.generateToken(user);

        

        tokenDAO.updateAllUserTokens(user.getId(), true);

        insertToken(user, jwt);

        return new AuthenticationResponse(jwt);
    }

    private void insertToken(User user, String jwt) {
        Token token = new Token();
        token.setToken(jwt);
        token.setUserId(userDAO.getUserByUsername(user.getEmail()).get().getId());
        token.setLoggedOut(false);
        tokenDAO.insertToken(token);
    }
}
