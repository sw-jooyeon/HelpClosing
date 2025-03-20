package cau.capstone.helpclosing.controller;

import cau.capstone.helpclosing.model.Entity.Invitation;
import cau.capstone.helpclosing.model.Entity.User;
import cau.capstone.helpclosing.model.Header;
import cau.capstone.helpclosing.model.Request.InviteRequest;
import cau.capstone.helpclosing.model.Request.MatchingAcceptRequest;
import cau.capstone.helpclosing.model.Request.MatchingRejectRequest;
import cau.capstone.helpclosing.model.Response.InvitationListResponse;
import cau.capstone.helpclosing.model.Response.PossibleInvitationList;
import cau.capstone.helpclosing.service.MatchingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.Authentication;

import java.util.List;

@RestController
public class MatchingController {
    @Autowired
    private MatchingService matchingService;

    @PostMapping("/matching/invite")
    //@ApiOperation(value= "Add friends", notes = "")
    public String invite(@RequestBody InviteRequest inviteRequest){

        return matchingService.inviteAround(inviteRequest);
    }

//    @PostMapping("/invite")
//    //@ApiOperation(value="그룹 안에서 초대", notes = "receiver(email), chatRoomId 필요")
//    public Header InviteToExistMatching(@RequestBody InviteToExistRequest inviteToExistRequest){
//        try{
//            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//            String email = ((User) auth.getPrincipal()).getEmail();
//
//            return Header.OK(matchingService.inviteToExist(email, inviteToExistRequest));
//        }
//        catch (Exception e){
//            return Header.ERROR("Need to login for inviting");
//        }
//    }
//
//    @GetMapping("/possibleinvite")
//    //@ApiOperation(value="그룹에 초대 가능한 user목록 출력", notes = "초대 그룹 id 필요")
//    public Header<PossibleInvitationList> possibleInvite(Long chatRoomId){
//        try{
//            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//            String email = ((User) auth.getPrincipal()).getEmail();
//
//            return Header.OK(matchingService.possibleInvite(chatRoomId),"");
//        }
//        catch (Exception e){
//            return Header.ERROR("Need to login for seeing possible user for invitation" + e);
//        }
//    }

    @GetMapping("/matching/invitedList")
    //@ApiOperation(value="초대 받은 목록(invitation) 보기", notes = "")
    public Header<List<Invitation>> inviteList(@RequestParam String email){
        try {
            return Header.OK(matchingService.inviteList(email), "");
        }
        catch (Exception e){
            return Header.ERROR("Need to login for seeing invitedList");
        }
    }

    @PostMapping("/matching/accept")
    //@ApiOperation(value="초대 수락", notes ="sender email, chatRoomId: null일 경우 0으로 줘야함.")
    public Header accept(@RequestBody MatchingAcceptRequest matchingAcceptRequest){


            return Header.OK(matchingService.accept(matchingAcceptRequest), "");

    }

    @DeleteMapping("/matching/reject")
    // @ApiOperation(value = "초대 거절", notes = "sender email, roomid: null일 경우 0으로 줘야함. ")
    public Header reject(@RequestBody MatchingRejectRequest matchingRejectRequest){
        try {
            return Header.OK(matchingService.reject(matchingRejectRequest), "");
        }
        catch (Exception e){
            return Header.ERROR("Need to login for rejecting matching");
        }
    }
}
