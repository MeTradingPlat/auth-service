package com.metradingplat.auth.payload.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

import java.util.Set;

@Data
public class SignupRequest {
    @NotBlank
    private String username;

    @NotBlank
    private String password;

    private Set<String> roles;
}
