//
//  PCParser.m
//  calculator
//
//  Created by Pavel Ivanov on 07/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCParser.h"
#import "PCGroupToken.h"
#import "PCOperatorSet.h"

#import "PCNumberExtractor.h"
#import "PCOperatorExtractor.h"
#import "PCGroupExctractor.h"
#import "NSError+PCError.h"
#import "PCTokenCharacterBuffer.h"


@interface PCParser()

@property (nonatomic) NSArray      *allowedOperandSymbols;
@property (nonatomic) NSArray      *extractors;
@property (nonatomic, strong) PCOperatorSet *operatorSet;

@end

@implementation PCParser

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.operatorSet = [PCOperatorSet defaultOperatorSet];
        
        
        self.extractors = @[[[PCNumberExtractor alloc] init],
                            [PCOperatorExtractor initWithOperators:self.operatorSet.operators],
                            [[PCGroupExctractor alloc] init]];
    }
    
    return self;
}

-(NSArray*)tokenizeString:(NSString*)mathString error:(NSError**)error
{
    PCTokenCharacterBuffer *buffer = [PCTokenCharacterBuffer initWithString:mathString];
    NSMutableArray *resultTokens = @[].mutableCopy;
    
    for ( ; buffer.currentIndex <= buffer.endIndex ; ) {
        PCToken *token = nil;
        for (PCExtractor *extractor in self.extractors) {
            NSUInteger startIndex = buffer.currentIndex;
            
            if ([extractor matchesPreconditionsInBuffer:buffer]) {
                [buffer resetTo:startIndex];
                NSError *exctractingError;
                token = [extractor extractFromBuffer:buffer error:&exctractingError];
                if (!token) {
                    *error = exctractingError;
                    return nil;
                }
                
                break;
            }
        }
        
        if (!token) {
            if (error != NULL) {
                *error = [NSError buildErrorWithDescription:@"Invalid input" code:0];
            }
            
            return nil;
        }
    
        if ([token isKindOfClass:[PCGroupToken class]]) {
            PCGroupToken *groupToken = (PCGroupToken*)token;
            NSArray *groupedTokens = [self tokenizeString:groupToken.mnemonic error:error];
            groupToken.groupedTokens = groupedTokens;
        }
        
        [resultTokens addObject:token];
        [buffer consumeCharacters:1];
    }
    
    return resultTokens;
}

@end
