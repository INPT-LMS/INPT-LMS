package com.inpt.lms.servicegestioncomptes.util;

import com.inpt.lms.servicegestioncomptes.model.UserInfos;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.stereotype.Service;

@Service
public class JWTUtil {
    private String SECRET_JWT="secret";

    public String generateToken(UserInfos userInfos){
        return createToken(userInfos.getId());
    }

    // TODO Vérifier date expiration - validité
    private String createToken(Long subject ){
        return Jwts.builder().claim("userId",subject).signWith(SignatureAlgorithm.HS256,SECRET_JWT).compact();
    }
}
