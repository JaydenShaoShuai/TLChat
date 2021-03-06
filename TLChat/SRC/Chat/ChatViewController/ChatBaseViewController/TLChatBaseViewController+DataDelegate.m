//
//  TLChatBaseViewController+DataDelegate.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatBaseViewController+DataDelegate.h"
#import "TLChatBaseViewController+ChatTableView.h"

@implementation TLChatBaseViewController (DataDelegate)

- (void)sendMessage:(TLMessage *)message
{
    message.ownerTyper = TLMessageOwnerTypeSelf;
    message.userID = [TLUserHelper sharedHelper].userID;
    message.fromUser = (id<TLChatUserProtocol>)[TLUserHelper sharedHelper].user;
    message.date = [NSDate date];
    
    if ([self.partner chat_userType] == TLChatUserTypeUser) {
        message.partnerType = TLPartnerTypeUser;
        message.friendID = [self.partner chat_userID];
    }
    else if ([self.partner chat_userType] == TLChatUserTypeGroup) {
        message.partnerType = TLPartnerTypeGroup;
        message.groupID = [self.partner chat_userID];
    }
    
    if (message.messageType != TLMessageTypeVoice) {
        [self addToShowMessage:message];    // 添加到列表
    }
    else {
        [self.messageDisplayView updateMessage:message];
    }
    
    [[TLMessageManager sharedInstance] sendMessage:message progress:^(TLMessage * message, CGFloat pregress) {
        
    } success:^(TLMessage * message) {
        NSLog(@"send success");
    } failure:^(TLMessage * message) {
        NSLog(@"send failure");
    }];
}

- (void)receivedMessage:(TLMessage *)message
{
    message.userID = [TLUserHelper sharedHelper].userID;
    if ([self.partner chat_userType] == TLChatUserTypeUser) {
        message.partnerType = TLPartnerTypeUser;
        message.friendID = [self.partner chat_userID];
    }
    else if ([self.partner chat_userType] == TLChatUserTypeGroup) {
        message.partnerType = TLPartnerTypeGroup;
        message.groupID = [self.partner chat_userID];
    }
    message.ownerTyper = TLMessageOwnerTypeFriend;
    message.date = [NSDate date];
    [self addToShowMessage:message];    // 添加到列表
    
    [[TLMessageManager sharedInstance] sendMessage:message progress:^(TLMessage * message, CGFloat pregress) {
        
    } success:^(TLMessage * message) {
        NSLog(@"send success");
    } failure:^(TLMessage * message) {
        NSLog(@"send failure");
    }];
}

@end
