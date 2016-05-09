//
//  PCGroupExctractor.m
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCGroupExctractor.h"
#import "NSCharacterSet+PCCharacterSet.h"
#import "PCGroupToken.h"

@implementation PCGroupExctractor

-(BOOL)matchesPreconditionsInBuffer:(PCTokenCharacterBuffer*)buffer
{
    unichar character = [buffer getCurrentCharacter];
    return [[NSCharacterSet openGroupingSet] characterIsMember:character];
}

-(PCToken*)extractFromBuffer:(PCTokenCharacterBuffer*)buffer error:(NSError *__autoreleasing *)error
{
    NSUInteger startPosition = buffer.currentIndex;
    NSUInteger stopIndex;
    
    BOOL closeBracketFound = NO;
    do {
        [buffer consumeCharacters:1];
        if (![[[NSCharacterSet closeGroupingSet] invertedSet] characterIsMember:[buffer getCurrentCharacter]]) {
            closeBracketFound = YES;
            break;
        }
    } while (buffer.currentIndex < buffer.endIndex);
    
    if (!closeBracketFound) {
        if (error != NULL) {
            *error = [NSError buildErrorWithDescription:@"Closing parenthesis is missing!" code:0];
        }
        
        return nil;
    }
    
    stopIndex = buffer.currentIndex;
    
    NSString *result = [buffer substringFromIndex:startPosition ToIndex:stopIndex];
    PCGroupToken *groupToken = [[PCGroupToken alloc] init];
    result = [result stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
    result = [result stringByReplacingCharactersInRange:NSMakeRange(result.length-1, 1) withString:@""];
    groupToken.mnemonic = result;
    return groupToken;
}

@end
