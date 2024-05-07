package com.cs491.vendar.api;

import java.nio.file.AccessDeniedException;

import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

import com.cs491.vendar.model.User;
import com.cs491.vendar.responses.AuthenticationResponse;
import com.cs491.vendar.service.AuthenticationService;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.CrossOrigin;




@RestController
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
public class AuthenticationController {
    
    private final AuthenticationService authService;
    
    @PostMapping("/register")
    public ResponseEntity<AuthenticationResponse> register(@RequestBody User request) {
        try{
            return  ResponseEntity.ok(authService.register(request));
        }
        catch (AccessDeniedException e){ 
            return ResponseEntity.status(HttpStatusCode.valueOf(409)).body(new AuthenticationResponse(null));
        }
        
    }

    @PostMapping("/login")
    public ResponseEntity<AuthenticationResponse> login(@RequestBody User request) {
        return ResponseEntity.ok(authService.authenticate(request));
    }
    
}
