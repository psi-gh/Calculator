//
//  PCMultiplicationOperationToken.m
//  calculator
//
//  Created by Pavel Ivanov on 09/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCMultiplicationOperationToken.h"

@implementation PCMultiplicationOperationToken

-(NSString *)mnemonic
{
    return @"*";
}

-(NSNumber *)getValueWithInputValues:(NSArray *)values
{
    double result = ((NSNumber*)values.firstObject).doubleValue;
    for (int i = 1; i <= values.count-1; i++) {
        NSNumber *nextValue = values[i];
        result = result * nextValue.doubleValue;
    }
    
    return @(result);
}

@end
