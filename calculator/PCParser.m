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

-(NSArray*)tokenizeString:(NSString*)mathString
{
    PCTokenCharacterBuffer *buffer = [PCTokenCharacterBuffer initWithString:mathString];
    NSMutableArray *resultTokens = @[].mutableCopy;
    
    for ( ; buffer.currentIndex <= buffer.endIndex ; ) {
        PCToken *token = nil;
        for (PCExtractor *extractor in self.extractors) {
            NSUInteger startIndex = buffer.currentIndex;
            
            // TODO: Error when can't parse
            if ([extractor matchesPreconditionsInBuffer:buffer]) {
                [buffer resetTo:startIndex];
                token = [extractor extractFromBuffer:buffer];
                break;
            }
        }
        
        if (!token) {
            NSLog(@"error");
            return nil;
        }
    
        if ([token isKindOfClass:[PCGroupToken class]]) {
            PCGroupToken *groupToken = (PCGroupToken*)token;
            NSArray *groupedTokens = [self tokenizeString:groupToken.mnemonic];
            groupToken.groupedTokens = groupedTokens;
        }
        
        [resultTokens addObject:token];
        [buffer consumeCharacters:1];
    }
    
    return resultTokens;
}

@end
