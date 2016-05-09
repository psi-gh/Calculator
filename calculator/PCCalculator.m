//
//  PCCalculator.m
//  calculator
//
//  Created by Pavel Ivanov on 09/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCCalculator.h"
#import "PCParser.h"
#import "PCEvaluatingTreeBuilder.h"
#import "PCGrouper.h"

@implementation PCCalculator

-(NSNumber *)evalString:(NSString*)evaluationString error:(NSError**)error
{
    PCParser *parser = [[PCParser alloc] init];
    NSError *parserError;
    NSArray *tokensArray = [parser tokenizeString:evaluationString error:&parserError];
    
    if (!tokensArray) {
        if (parserError) {
            *error = parserError;
        }
        
        return nil;
    }
    
    PCGrouper *grouper = [[PCGrouper alloc] init];
    NSArray *groupingResult = [grouper groupAllTokensInArray:tokensArray];
    PCEvaluationTreeNode *rootNode = [PCEvaluatingTreeBuilder generateEvaluationTreeFromGroupedTokens:groupingResult];
    NSNumber *result = [rootNode getResult];
    return result;
}

@end
