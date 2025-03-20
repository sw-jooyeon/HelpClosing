package cau.capstone.helpclosing.model.Response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PossibleInvitationList {

    List<UserProfileResponse> possibleProfileList;
}
