//
//  PCOperatorSet.h
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCToken.h"

@interface PCOperatorSet : NSObject

typedef NS_ENUM(NSUInteger, PCPrecedenceRelated) {
    PCPrecedenceRelatedGreater,
    PCPrecedenceRelatedLess,
    PCPrecedenceRelatedEqual
};

typedef NS_ENUM(NSUInteger, DDPrecedence) {
    DDPrecedenceBitwiseOr = 0,
    DDPrecedenceBitwiseXor,
    DDPrecedenceBitwiseAnd,
    DDPrecedenceLeftShift,
    DDPrecedenceRightShift,
    DDPrecedenceSubtraction,
    DDPrecedenceAddition = DDPrecedenceSubtraction,
    DDPrecedenceDivision,
    DDPrecedenceMultiplication = DDPrecedenceDivision,
    DDPrecedenceModulo,
    DDPrecedenceUnary,
    DDPrecedenceFactorial,
    DDPrecedencePower,
    DDPrecedenceParentheses,
    
    DDPrecedenceUnknown = -1,
    DDPrecedenceNone = -2
};

@property (nonatomic, readonly) NSArray      *operators;
@property (nonatomic, ) NSDictionary *precedenceDictionary;

+ (id)defaultOperatorSet;

-(void)addOperation:(PCToken*)operandToken precedence:(DDPrecedence)precedence;

@end
