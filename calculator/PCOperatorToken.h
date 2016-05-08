//
//  PCOperatorToken.h
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCToken.h"

@interface PCOperatorToken : PCToken

typedef NS_ENUM(NSUInteger, PCArity) {
    PCArityUnary,
    PCArityBinary
};

typedef NS_ENUM(NSUInteger, PCAssociativity) {
    PCAssociativityLeft,
    PCAssociativityRight
};

@property (nonatomic, assign) PCArity arity;
@property (nonatomic, assign) PCAssociativity associativity;

-(NSNumber*)getValueWithInputValues:(NSArray*)values;

@end
