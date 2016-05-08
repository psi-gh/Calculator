//
//  PCParser.m
//  calculator
//
//  Created by Pavel Ivanov on 07/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCParser.h"
#import "PCToken.h"

#import "PCNumberExtractor.h"
#import "PCOperatorExtractor.h"

#import "PCAddOperatorToken.h"

#import "PCTokenCharacterBuffer.h"


@interface PCParser()

@property (nonatomic) NSArray *operators;
@property (nonatomic) NSArray *allowedOperandSymbols;
@property (nonatomic) NSArray *extractors;

@end

@implementation PCParser

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.operators = @[[[PCAddOperatorToken alloc] init]];
        self.extractors = @[[[PCNumberExtractor alloc] init],
                            [PCOperatorExtractor initWithOperators:self.operators]];
    }
    
    return self;
}

-(NSArray*)tokenizeString:(NSString*)mathString
{
    PCTokenCharacterBuffer *buffer = [PCTokenCharacterBuffer initWithString:mathString];
    
    NSMutableArray *resultTokens = @[].mutableCopy;
    
    for (; buffer.currentIndex <= buffer.endIndex;) {
//        while ([[NSCharacterSet symbolCharacterSet] characterIsMember:[buffer getCurrentCharacter]]) {
//            [buffer consumeCharacters:1];
//        }
        
        for (PCExtractor *extractor in self.extractors) {
            NSUInteger startIndex = buffer.currentIndex;
            if ([extractor matchesPreconditionsInBuffer:buffer]) {
                [buffer resetTo:startIndex];
                PCToken *token = [extractor extractFromBuffer:buffer];
                [resultTokens addObject:token];
                break;
            }
        }
    }
    
    return resultTokens;
}

-(void)parseForceParenthesesFormEvaluation:(NSString*)mathString
{
	
}

@end
