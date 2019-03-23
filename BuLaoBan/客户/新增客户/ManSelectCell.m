//
//  ManSelectCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/20.
//  Copyright © 2019 XX. All rights reserved.
//

#import "ManSelectCell.h"
#import "Participants.h"
#import "CompanyUsers.h"


@implementation ManSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];

    
}


-(void)setParticipants:(Participants *)participants{
    _participants = participants;
    [_faceIma sd_setImageWithURL:[NSURL URLWithString:participants.avatar] placeholderImage:nil];
    _nameLab.text = participants.userName;
}

-(void)setCompanyUsers:(CompanyUsers *)companyUsers{
    _companyUsers = companyUsers;
    [_faceIma sd_setImageWithURL:[NSURL URLWithString:companyUsers.avatar] placeholderImage:nil];
    _nameLab.text = companyUsers.name;
    
}



@end
