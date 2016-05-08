//
//  PCOperatorSet.m
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCOperatorSet.h"
#import "PCAddOperatorToken.h"
#import "PCSubstractOperatorToken.h"

@implementation PCOperatorSet

+ (id)defaultOperatorSet {
    static PCOperatorSet *defaultOperatorSet = nil;
    @synchronized(self) {
        if (defaultOperatorSet == nil)
            defaultOperatorSet = [[self alloc] init];
    }
    
    return defaultOperatorSet;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self -> _operators = @[];
        self -> _precedenceDictionary = @{};
        
        [self addOperation:[[PCAddOperatorToken alloc] init] precedence:DDPrecedenceAddition];
        [self addOperation:[[PCSubstractOperatorToken alloc] init] precedence:DDPrecedenceAddition];
    }
    return self;
}

-(void)addOperation:(PCToken*)operandToken precedence:(DDPrecedence)precedence {
    self -> _operators = [self -> _operators arrayByAddingObject:operandToken];
    NSMutableDictionary *mPrecedence = [[NSMutableDictionary alloc]initWithDictionary:self -> _precedenceDictionary];
    mPrecedence[operandToken.mnemonic] = @(precedence);
    self -> _precedenceDictionary = [[NSDictionary alloc] initWithDictionary:mPrecedence];
}

-(DDPrecedence)precedenceForOperation:(PCToken*)operation
{
    for (NSString *operandMnemonic in self.precedenceDictionary) {
        if ([operandMnemonic isEqualToString:operation.mnemonic]) {
            return ((NSNumber*)self.precedenceDictionary[operandMnemonic]).integerValue;
        }
    }
    
    return DDPrecedenceUnknown;
}

-(NSCharacterSet *)getAllOperationsSymbols
{
    NSString *allSymbolsString = @"";
    for (PCOperatorToken *operatorToken in self.operators) {
        allSymbolsString = [allSymbolsString stringByAppendingString:operatorToken.mnemonic];
    }
    
    return [NSCharacterSet characterSetWithCharactersInString:allSymbolsString];
}

@end
