package com.inpt.lms.servicegestioncomptes.util;

import com.inpt.lms.servicegestioncomptes.model.UserInfos;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;

@Service
public class JWTUtil {
    private String SECRET_JWT="secret";

    public String generateToken(UserInfos userInfos){
        return createToken(userInfos.getId());
    }

    // TODO Vérifier date expiration - validité
    private String createToken(Long subject){
        return Jwts.builder().claim("userId",subject).signWith(SignatureAlgorithm.HS512,SECRET_JWT.getBytes(StandardCharsets.UTF_8)).compact();
    }
}
