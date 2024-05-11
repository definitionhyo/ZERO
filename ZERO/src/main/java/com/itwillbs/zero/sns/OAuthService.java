package com.itwillbs.zero.sns;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.itwillbs.zero.vo.GoogleOAuthResponseVO;

import lombok.RequiredArgsConstructor;

@Service
@Component
@RequiredArgsConstructor
public class OAuthService {

    private final String GOOGLE_TOKEN_URL = "https://oauth2.googleapis.com/token";
    @Value("${google_client_id}")
    private String GOOGLE_CLIENT_ID;
    @Value("${google_client_secret}")
    private String GOOGLE_CLIENT_SECRET;
    @Value("${google_redirect_uri}")
    private String LOGIN_REDIRECT_URL;

    public ResponseEntity<GoogleOAuthResponseVO> getGoogleAccessToken(String accessCode) {

        RestTemplate restTemplate=new RestTemplate();
        Map<String, String> params = new HashMap<>();
        
        params.put("code", accessCode);
        params.put("client_id", GOOGLE_CLIENT_ID);
        params.put("client_secret", GOOGLE_CLIENT_SECRET);
        params.put("redirect_uri", LOGIN_REDIRECT_URL);
        params.put("grant_type", "authorization_code");

        ResponseEntity<GoogleOAuthResponseVO> responseEntity=restTemplate.postForEntity(GOOGLE_TOKEN_URL, params, GoogleOAuthResponseVO.class);
        
        if(responseEntity.getStatusCode() == HttpStatus.OK){
            return responseEntity;
        }
        return null;
    }
    
    
}
