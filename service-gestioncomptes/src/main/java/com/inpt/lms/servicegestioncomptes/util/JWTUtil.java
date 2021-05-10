package com.inpt.lms.servicegestioncomptes.util;

import com.inpt.lms.servicegestioncomptes.model.UserInfos;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.stereotype.Service;

import java.security.Key;
import java.util.Base64;

@Service
public class JWTUtil {
    private String SECRET_JWT="VnLsaJ0Z3eHhxHnGaBBJLfQaZIrk4VaawwWqL9lkCQk=";

    public String generateToken(UserInfos userInfos){
        return createToken(userInfos.getId());
    }

    // TODO Vérifier date expiration - validité
    private String createToken(Long subject){
        byte[] DEC_SECRET = Base64.getDecoder().decode(SECRET_JWT);
        Key k = Keys.hmacShaKeyFor(DEC_SECRET);

        return Jwts.builder().claim("userId",subject).signWith(k).compact();
    }
}
