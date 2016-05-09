//
//  PCOperatorToken.m
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCOperatorToken.h"

@implementation PCOperatorToken

-(PCArity)arity
{
    return PCArityBinary;
}

-(PCAssociativity)associativity
{
    return PCAssociativityLeft;
}

-(NSNumber *)getValueWithInputValues:(NSArray *)values
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
    
}

@end
