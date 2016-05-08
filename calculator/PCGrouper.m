//
//  PCGrouper.m
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCGrouper.h"
#import "PCOperatorSet.h"
#import "PCOperatorToken.h"
#import "PCPrimitiveValueToken.h"
#import "PCGroupToken.h"

@interface PCGrouper()

//@property (nonatomic, assign) NSUInteger currentTokenIndex;
//@property (nonatomic, strong) NSMutableArray *tokens;
@property (nonatomic, assign) NSUInteger endIndex;

@end

@implementation PCGrouper

//-(NSArray *)groupAllTokensInArray:(NSArray*)tokens {
//    self.tokens = [NSMutableArray arrayWithArray:tokens];
//    self.currentTokenIndex = 0;
//    id token;
//    id nextToken = nil;
//    id lhs;
//    
//    NSMutableArray *arrayForNewGroup;
//    
//    DDPrecedence *currentPrecedence = 0;
//    
//    NSUInteger indexOfLfs = 0;
//    NSUInteger indexOfOperand = 0;
//    NSUInteger indexOfRfs = 0;
//    NSUInteger indexOfNextOperand = 0;
//
//    while (1) {
//        arrayForNewGroup = @[].mutableCopy;
//        token =  self.tokens[self.currentTokenIndex];
//        while (![token isKindOfClass:[PCOperatorToken class]]) {
//            [self consume];
//            token = self.tokens[self.currentTokenIndex];
//        }
//        
//        indexOfOperand = self.currentTokenIndex;
//        indexOfLfs = self.currentTokenIndex - 1;
//        
//        [arrayForNewGroup addObject:self.tokens[self.currentTokenIndex - 1]];
//        [arrayForNewGroup addObject:self.tokens[self.currentTokenIndex]];
//        
//        
//        do {
//            if (self.currentTokenIndex == self.endIndex) {
//                [arrayForNewGroup addObject:self.tokens[self.currentTokenIndex]];
//                nextToken = nil;
//                break;
//            }
//            
//            [self consume];
//            nextToken = self.tokens[self.currentTokenIndex];
//        } while (![nextToken isKindOfClass:[PCOperatorToken class]]);
//        
//        indexOfNextOperand = self.currentTokenIndex;
//        
//        if ([[PCOperatorSet defaultOperatorSet] precedenceForOperation:token] >=
//            [[PCOperatorSet defaultOperatorSet] precedenceForOperation:nextToken]) {
//            self.currentTokenIndex -= 1;
//            [arrayForNewGroup addObject:self.tokens[self.currentTokenIndex]];
//            PCGroupToken *groupToken = [[PCGroupToken alloc] init];
//            groupToken.groupedTokens = [NSArray arrayWithArray:arrayForNewGroup];
//            [self.tokens insertObject:groupToken atIndex:self.currentTokenIndex];
//            [self.tokens removeObjectsInArray:arrayForNewGroup];
//            if (nextToken != nil) self.currentTokenIndex = [self.tokens indexOfObject:nextToken];
//        }
//        
//        if (nextToken == nil) {
//            break;
//        }
//    }
//    
//    return tokens;
//}

-(NSArray *)groupAllTokensInArray:(NSArray*)tokens {
    NSMutableArray *resultTokens = [NSMutableArray arrayWithArray:tokens];

    for (PCToken *token in resultTokens) {
        if ([token isKindOfClass:[PCGroupToken class]]) {
            PCGroupToken *groupToken = (id)token;
            groupToken.groupedTokens = [self groupAllTokensInArray:groupToken.groupedTokens];
        }
    }
    
    NSMutableArray *arrayForNewGroup;
    
    do {
       // find operator with hightest precedence
        DDPrecedence maxPrecedence = -1;
        PCToken *tokenWithMaxPrecedence = nil;

        for (PCOperatorToken *token in resultTokens) {
            if ([token isKindOfClass:[PCOperatorToken class]]) {
                DDPrecedence precedenceOfToken = [[PCOperatorSet defaultOperatorSet] precedenceForOperation:token];
                if (precedenceOfToken > maxPrecedence) {
                    maxPrecedence = precedenceOfToken;
                    tokenWithMaxPrecedence = token;
                }
            }
        }
        
        if (maxPrecedence == -1) {
            break;
        }
        
        // put operator with left and right operand in group
        NSInteger indexOfToken = [resultTokens indexOfObject:tokenWithMaxPrecedence];
        arrayForNewGroup = [NSMutableArray arrayWithArray:@[resultTokens[indexOfToken-1],
                                                            resultTokens[indexOfToken],
                                                            resultTokens[indexOfToken+1]]];
        PCGroupToken *groupToken = [[PCGroupToken alloc] init];
        groupToken.groupedTokens = [NSArray arrayWithArray:arrayForNewGroup];
        [resultTokens insertObject:groupToken atIndex:indexOfToken];
        [resultTokens removeObjectsInArray:arrayForNewGroup];
        
    } while (1);
    
    return resultTokens;
}

-(PCEvaluationTreeNode*)generateEvaluationTreeFromGroupedTokens:(NSArray *)tokens
{
    PCEvaluationTreeNode *node = nil;
    for (PCToken *token in tokens) {
        if ([token isKindOfClass:[PCGroupToken class]]) {
            node = [[PCEvaluationTreeNode alloc] init];
            [self fillNode:node WithTokens:((PCGroupToken*)token).groupedTokens];
        }
    }
    
    return node;
}

-(void)fillNode:(PCEvaluationTreeNode*)node WithTokens:(NSArray*)tokens {
    for (PCToken *token in tokens) {
        if ([token isKindOfClass:[PCGroupToken class]]) {
            PCEvaluationTreeNode *complexNode = [[PCEvaluationTreeNode alloc] init];
            [self fillNode:complexNode WithTokens:((PCGroupToken*)token).groupedTokens];
            [node.childNodes addObject:complexNode];
        } else if ([token isKindOfClass:[PCPrimitiveValueToken class]]) {
            PCEvaluationTreeNode *leafNode = [[PCEvaluationTreeNode alloc] init];
            leafNode.token = token;
            [node.childNodes addObject:leafNode];
        } else if ([token isKindOfClass:[PCOperatorToken class]]) {
            node.token = token;
        }
    }
}

//
//-(PCEvaluationTreeNode*)generateEvaluationTreeFromTokensArray:(NSArray *)tokens
//{
//    self.tokens = tokens;
//    self.currentTokenIndex = 0;
//    id token = self.tokens[self.currentTokenIndex];
//    id lhs;
//    PCEvaluationTreeNode *node = [[PCEvaluationTreeNode alloc] init];
//    PCEvaluationTreeNode *currentNode = node;
//    DDPrecedence *currentPrecedence = 0;
//
//    for (;self.currentTokenIndex < self.endIndex;) {
//        
////        if ([token isKindOfClass:[PCPrimitiveValueToken class]]) {
////            lhs = token;
////            if ([self peekNextToken]
////        }
//
//        if ([token isKindOfClass:[PCPrimitiveValueToken class]]) {
//            if (!lhs) {
//                lhs = token;
//                [currentNode.childTokens addObject:lhs];
//                [self consume];
//            }
//        } else if ([token isKindOfClass:[PCOperatorToken class]]) {
//            currentPrecedence = PCOperatorToken
//            if (lhs) {
//                currentNode.token = token;
//                do {
//                    [self consume]
//                }
//            }
//        }
//
//        
////        if ([token isKindOfClass:[PCPrimitiveValueToken class]]) {
////            
////        } else if ([token isKindOfClass:[PCOperatorToken class]]) {
////            
////        }
//    }
//}

//
//-(PCToken*)parseExpressionWithLhs:(PCToken*)lhs minPrecedence:(DDPrecedence)precedence {
//    return nil;
//}
//    
//-(PCToken*)peekNextToken {
//    return self.tokens[self.currentTokenIndex+1];
//}
//
//-(void)consume {
//    self.currentTokenIndex += 1;
//}
//
//-(NSUInteger)endIndex
//{
//    return (self.tokens.count - 1);
//}
//

@end
