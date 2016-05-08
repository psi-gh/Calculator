//
//  calculatorTests.m
//  calculatorTests
//
//  Created by Pavel Ivanov on 07/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PCParser.h"
#import "PCNumberToken.h"
#import "PCAddOperatorToken.h"
#import "PCSubstractOperatorToken.h"
#import "PCGroupToken.h"
#import "PCGrouper.h"

@interface calculatorTests : XCTestCase

@end

@implementation calculatorTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTokenizeSingleFloatNumber {
    NSString *mathString = @"33.456";
    
    PCParser *parser = [[PCParser alloc] init];
    NSArray *result = [parser tokenizeString:mathString];
    PCNumberToken *resultToken = result.firstObject;
    
    XCTAssertEqual(result.count, 1);
    XCTAssertEqual([result.firstObject isKindOfClass:[PCNumberToken class]], YES);
    XCTAssertEqual([resultToken getValue].floatValue, @(33.456).floatValue);
}

- (void)testTokenizeGrouping {
    NSString *mathString = @"(1+2)";
    
    PCParser *parser = [[PCParser alloc] init];
    NSArray *result = [parser tokenizeString:mathString];
    PCGroupToken *resultToken = result.firstObject;
    
    XCTAssertEqual(result.count, 1);
    XCTAssertEqual([result.firstObject isKindOfClass:[PCGroupToken class]], YES);
    XCTAssertEqual([resultToken.mnemonic isEqualToString:@"1+2"], YES);
}

- (void)testTokenizeSimpleAddOperation {
    NSString *mathString = @"1+2";
    
    PCParser *parser = [[PCParser alloc] init];
    NSArray *result = [parser tokenizeString:mathString];
    
    XCTAssertEqual(result.count, 3);
    XCTAssertEqual([result[1] isKindOfClass:[PCAddOperatorToken class]], YES);
}

- (void)testTokenizeSimpleSubstractOperation {
    NSString *mathString = @"1-2";
    
    PCParser *parser = [[PCParser alloc] init];
    NSArray *result = [parser tokenizeString:mathString];
    
    XCTAssertEqual(result.count, 3);
    XCTAssertEqual([result[1] isKindOfClass:[PCSubstractOperatorToken class]], YES);
}

- (void)testTokenizeStringWithManyOperationsAndGrouping {
    NSString *mathString = @"3-(1+2)+4";
    
    PCParser *parser = [[PCParser alloc] init];
    NSArray *result = [parser tokenizeString:mathString];
    PCGroupToken *groupToken = result[2];

    XCTAssertEqual(result.count, 5);
    XCTAssertEqual(groupToken.groupedTokens.count, 3);
}

- (void)testGrouping {
    NSString *mathString = @"3+(2+1)+1";
    PCParser *parser = [[PCParser alloc] init];
    NSArray *tokensArray = [parser tokenizeString:mathString];
    
    PCGrouper *grouper = [[PCGrouper alloc] init];
    NSArray *groupingResult = [grouper groupAllTokensInArray:tokensArray];
    PCGroupToken *groupedToken1lvl = groupingResult.firstObject;
    PCGroupToken *groupedToken2lvl = groupedToken1lvl.groupedTokens.firstObject;
    PCNumberToken *number2lvl = groupedToken1lvl.groupedTokens.lastObject;
    PCGroupToken *groupedToken3lvl = groupedToken2lvl.groupedTokens.lastObject;
    PCGroupToken *groupedToken4lvl = groupedToken3lvl.groupedTokens.lastObject;
    
    XCTAssertEqual(groupingResult.count, 1);
    XCTAssertEqual([groupedToken1lvl isKindOfClass:[PCGroupToken class]], YES);
    XCTAssertEqual([groupedToken2lvl isKindOfClass:[PCGroupToken class]], YES);
    XCTAssertEqual([groupedToken3lvl isKindOfClass:[PCGroupToken class]], YES);
    XCTAssertEqual([groupedToken4lvl isKindOfClass:[PCGroupToken class]], YES);
    XCTAssertEqual([number2lvl isKindOfClass:[PCNumberToken class]], YES);
}

- (void)testBuildingEvaluatingTree {
    NSString *mathString = @"3+(2+1)+1";
    PCParser *parser = [[PCParser alloc] init];
    NSArray *tokensArray = [parser tokenizeString:mathString];
    
    PCGrouper *grouper = [[PCGrouper alloc] init];
    NSArray *groupingResult = [grouper groupAllTokensInArray:tokensArray];
    PCEvaluationTreeNode *rootNode = [grouper generateEvaluationTreeFromGroupedTokens:groupingResult];
    PCEvaluationTreeNode *firstNode2lvl = rootNode.childNodes.firstObject;
    PCEvaluationTreeNode *secondNode2lvl = rootNode.childNodes.lastObject;
    
    XCTAssertEqual(rootNode!=nil, YES);
    XCTAssertEqual([rootNode.token isKindOfClass:[PCAddOperatorToken class]], YES);
    XCTAssertEqual(rootNode.childNodes.count == 2, YES);
    XCTAssertEqual([firstNode2lvl.token isKindOfClass:[PCAddOperatorToken class]], YES);
    XCTAssertEqual(firstNode2lvl.childNodes.count == 2, YES);
    XCTAssertEqual([secondNode2lvl.token isKindOfClass:[PCNumberToken class]], YES);
    XCTAssertEqual(secondNode2lvl.childNodes.count == 0, YES);
}

- (void)testEvaluate {
    NSString *mathString = @"3+(2+1)+1";
    PCParser *parser = [[PCParser alloc] init];
    NSArray *tokensArray = [parser tokenizeString:mathString];
    
    PCGrouper *grouper = [[PCGrouper alloc] init];
    NSArray *groupingResult = [grouper groupAllTokensInArray:tokensArray];
    PCEvaluationTreeNode *rootNode = [grouper generateEvaluationTreeFromGroupedTokens:groupingResult];
    NSNumber *result = [rootNode getResult];
    XCTAssertEqual([result isEqualToNumber:@(7)], YES);
}

- (void)testEvaluateWithTwoDifferentOperations {
    NSString *mathString = @"3+(2+1)-9";
    PCParser *parser = [[PCParser alloc] init];
    NSArray *tokensArray = [parser tokenizeString:mathString];
    
    PCGrouper *grouper = [[PCGrouper alloc] init];
    NSArray *groupingResult = [grouper groupAllTokensInArray:tokensArray];
    PCEvaluationTreeNode *rootNode = [grouper generateEvaluationTreeFromGroupedTokens:groupingResult];
    NSNumber *result = [rootNode getResult];
    XCTAssertEqual([result isEqualToNumber:@(-3)], YES);
}


@end
