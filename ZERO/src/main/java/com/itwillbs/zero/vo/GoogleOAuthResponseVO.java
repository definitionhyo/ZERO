package com.itwillbs.zero.vo;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
public class GoogleOAuthResponseVO {
    private String access_token;
    private String expires_in;
    private String scope;
    private String token_type;
    private String id_token;
}
