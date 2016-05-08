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
        self.operators = @[@"*", @"/", @"+", @"-"];
        self.allowedOperandSymbols = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @".", @"(", @")"];
        self.extractors = @[[[PCNumberExtractor alloc] init]];
    }
    
    return self;
}

-(NSString*)createForceParenthesesFormFromEvaluationString:(NSString*)mathString
{
	mathString = @"3+5*6";
    
    NSRange range;
    range.location = 0;
    range.length = mathString.length;
    for (NSString *operator in self.operators) {
        NSRange foundOperatorRange = [mathString rangeOfString:operator
                                                       options:NSCaseInsensitiveSearch
                                                         range:range];
    
//        if ([mathString substringWithRange:<#(NSRange)#>])
        // go left
        NSUInteger i = foundOperatorRange.location;
//        NSRange *leftSearch = foundOperatorRange;
//        leftSearch.location = i;
//        while ([mathString substringWithRange:foundOperatorRange]) {
//            <#statements#>
//        }
    }
    
    return mathString;
}

-(NSArray*)tokenizeString:(NSString*)mathString
{
    PCTokenCharacterBuffer *buffer = [PCTokenCharacterBuffer initWithString:mathString];
    
    NSMutableArray *resultTokens = @[].mutableCopy;
    
    for (; buffer.currentIndex < buffer.originalString.length;) {
        while ([[NSCharacterSet symbolCharacterSet] characterIsMember:[buffer getCurrentCharacter]]) {
            [buffer consumeCharacters:1];
        }
        
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
