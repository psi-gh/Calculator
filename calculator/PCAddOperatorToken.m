//
//  PCAddOperatorToken.m
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCAddOperatorToken.h"

@implementation PCAddOperatorToken

-(NSString *)mnemonic {
    return @"+";
}

-(NSNumber *)getValueWithInputValues:(NSArray *)values
{
    double result = 0;
    for (NSNumber *number in values) {
        result += number.doubleValue;
    }
    
    return @(result);
}

@end
