package com.cs491.vendar.model;

import java.util.Collection;
import java.util.List;
import java.util.UUID;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class User implements UserDetails {
    private UUID id;
    private String name;
    private String surname;
    private String password;
    private String email;
    private String phoneNumber;
    private UUID[] favoritedProducts;
    private Role role;

    public User(
        @JsonProperty("user_id") UUID id,
        @JsonProperty("user_name") String name,
        @JsonProperty("user_surname") String surname,
        @JsonProperty("user_password") String password,
        @JsonProperty("user_email") String email,
        @JsonProperty("user_phone") String phoneNumber,
        @JsonProperty("user_favorited_products") UUID[] favoritedProducts,
        @JsonProperty("user_role") Role role
    ) {
        setId(id);
        setName(name);
        setSurname(surname);
        setPassword(password);
        setEmail(email);
        setPhoneNumber(phoneNumber);
        setFavoritedProducts(favoritedProducts);
        setRole(role);
    }

    public User(){
        
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority(role.name()));
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

}
