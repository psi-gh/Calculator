//
//  PCEvaluatingTests.m
//  calculator
//
//  Created by Pavel Ivanov on 09/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PCParser.h"
#import "PCNumberToken.h"
#import "PCAddOperatorToken.h"
#import "PCMultiplicationOperationToken.h"
#import "PCSubstractOperatorToken.h"
#import "PCGroupToken.h"
#import "PCGrouper.h"

@interface PCEvaluatingTests : XCTestCase

@property(nonatomic, strong) PCParser *parser;

@end

@implementation PCEvaluatingTests

- (void)setUp {
    [super setUp];
    self.parser = [[PCParser alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEvaluate {
    NSString *mathString = @"3+(2+1)+1";
    NSError *error;
    NSArray *tokensArray = [self.parser tokenizeString:mathString error:&error];
    
    PCGrouper *grouper = [[PCGrouper alloc] init];
    NSArray *groupingResult = [grouper groupAllTokensInArray:tokensArray];
    PCEvaluationTreeNode *rootNode = [grouper generateEvaluationTreeFromGroupedTokens:groupingResult];
    NSNumber *result = [rootNode getResult];
    XCTAssertEqual([result isEqualToNumber:@(3+(2+1)+1)], YES);
}

- (void)testEvaluateDivision {
    NSString *mathString = @"16/2";
    NSError *error;
    NSArray *tokensArray = [self.parser tokenizeString:mathString error:&error];
    
    PCGrouper *grouper = [[PCGrouper alloc] init];
    NSArray *groupingResult = [grouper groupAllTokensInArray:tokensArray];
    PCEvaluationTreeNode *rootNode = [grouper generateEvaluationTreeFromGroupedTokens:groupingResult];
    NSNumber *result = [rootNode getResult];
    XCTAssertEqual([result isEqualToNumber:@(16/2)], YES);
}

- (void)testEvaluateOperationsWithEqualPrecedence {
    NSString *mathString = @"3+(2+1)-9";
    NSError *error;
    NSArray *tokensArray = [self.parser tokenizeString:mathString error:&error];
    
    PCGrouper *grouper = [[PCGrouper alloc] init];
    NSArray *groupingResult = [grouper groupAllTokensInArray:tokensArray];
    PCEvaluationTreeNode *rootNode = [grouper generateEvaluationTreeFromGroupedTokens:groupingResult];
    NSNumber *result = [rootNode getResult];
    XCTAssertEqual([result isEqualToNumber:@(3+(2+1)-9)], YES);
}

- (void)testEvaluateOperationsWithDifferentPrecedence {
    NSString *mathString = @"1+2*(3+4)";
    NSError *error;
    NSArray *tokensArray = [self.parser tokenizeString:mathString error:&error];
    
    PCGrouper *grouper = [[PCGrouper alloc] init];
    NSArray *groupingResult = [grouper groupAllTokensInArray:tokensArray];
    PCEvaluationTreeNode *rootNode = [grouper generateEvaluationTreeFromGroupedTokens:groupingResult];
    NSNumber *result = [rootNode getResult];
    XCTAssertEqual([result isEqualToNumber:@(1+2*(3+4))], YES);
}

@end
