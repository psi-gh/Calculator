//
//  PCOperatorExtractor.m
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCOperatorExtractor.h"
#import "PCOperatorSet.h"

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
    unichar character = [buffer getCurrentCharacter];
    return [[[PCOperatorSet defaultOperatorSet] getAllOperationsSymbols] characterIsMember:character];
}

-(PCToken*)extractFromBuffer:(PCTokenCharacterBuffer*)buffer error:(NSError *__autoreleasing *)error
{
    NSUInteger startPosition = buffer.currentIndex;
    NSUInteger stopIndex;
    
    
    while ((buffer.currentIndex < buffer.endIndex) &&
             [[[PCOperatorSet defaultOperatorSet] getAllOperationsSymbols] characterIsMember:[buffer peekNextCharacter]]) {
        [buffer consumeCharacters:1];
    }
    
    
    
    stopIndex = buffer.currentIndex;
    
    NSString *result = [buffer.originalString substringWithRange:NSMakeRange(startPosition, stopIndex-startPosition + 1)];
    
    [buffer resetTo:startPosition + result.length-1];

    for (PCToken *token in self.allowedOperators) {
        if ([token.mnemonic isEqualToString:result]) {
            PCToken *operatorToken = [[[token class] alloc] init];
            return operatorToken;
        }
    }
    
    if (error != NULL) {
        *error = [NSError buildErrorWithDescription:@"Invalid operator" code:0];
    }
    
    return nil;
}

@end
