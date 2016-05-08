//
//  PCGroupToken.h
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCToken.h"
#import "PCPrimitiveValueToken.h"

@interface PCGroupToken : PCPrimitiveValueToken

@property (nonatomic, strong) NSArray *groupedTokens;

@end
