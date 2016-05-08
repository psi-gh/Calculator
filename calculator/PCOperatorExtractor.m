//
//  PCOperatorExtractor.m
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCOperatorExtractor.h"

@interface PCOperatorExtractor()

@property (nonatomic, strong, readonly) NSArray *allowedOperators;

@end

@implementation PCOperatorExtractor

+(instancetype)initWithOperators:(NSArray*)ops
{
    PCOperatorExtractor *result = [[PCOperatorExtractor alloc] init];
    result -> _allowedOperators = ops;
    return result;
}

-(BOOL)matchesPreconditionsInBuffer:(PCTokenCharacterBuffer*)buffer
{
    NSString *nextCharacter = [buffer peekNextCharacters:1];
    unichar character;
    [nextCharacter getCharacters:&character range:NSMakeRange(0, 1)];
    
    return [[NSCharacterSet symbolCharacterSet] characterIsMember:character];
}

-(PCToken*)extractFromBuffer:(PCTokenCharacterBuffer*)buffer
{
    NSUInteger startPosition = buffer.currentIndex;
    NSUInteger stopIndex;
    
    do {
        [buffer consumeCharacters:1];
    } while ((buffer.currentIndex < buffer.endIndex) &&
             [[NSCharacterSet symbolCharacterSet] characterIsMember:[buffer peekNextCharacter]]);
    
    stopIndex = buffer.currentIndex;
    
    NSString *result = [buffer.originalString substringWithRange:NSMakeRange(startPosition, stopIndex-startPosition)];
    
    [buffer resetTo:startPosition + result.length-1];

    for (PCToken *token in self.allowedOperators) {
        if ([token.mnemonic isEqualToString:result]) {
            PCToken *operatorToken = [[[token class] alloc] init];
            return operatorToken;
        }
    }
    
    @throw @"Can't identify operator!";
    return nil;
}

@end
