package cau.capstone.helpclosing.model.Response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LoginResponse {
    private Long userId;
    private String jwtToken;
    private String email;
    private String name;
    private String nickName;

    private String urlPledgeRequest;
    private String urlPledgeResponse;

}
