//
//  PCNumberExtractor.m
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCNumberExtractor.h"
#import "PCNumberToken.h"
#import "NSCharacterSet+PCCharacterSet.h"

@implementation PCNumberExtractor

-(BOOL)matchesPreconditionsInBuffer:(PCTokenCharacterBuffer*)buffer
{
    unichar character = [buffer getCurrentCharacter];
    return [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:character];
}

-(PCToken*)extractFromBuffer:(PCTokenCharacterBuffer*)buffer
{
    NSString *string;
    string = [buffer.originalString substringWithRange:NSMakeRange(buffer.currentIndex, buffer.originalString.length - buffer.currentIndex)];
    NSArray *substrings = [string componentsSeparatedByCharactersInSet:
                            [[NSCharacterSet floatNumberCharacterSet] invertedSet]];
    NSString *foundString = substrings.firstObject;
    [buffer resetTo:buffer.currentIndex + foundString.length-1];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *resultNumber = [formatter numberFromString:foundString];
    
    if (resultNumber == nil) {
        @throw @"Error in number format";
    }
    
    PCNumberToken *result = [[PCNumberToken alloc] init];
    result.value = resultNumber;
    result.mnemonic = foundString;
    return result;
}

@end
