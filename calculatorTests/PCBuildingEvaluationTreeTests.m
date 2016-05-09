//
//  PCBuildingEvaluationTreeTests.m
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

@interface PCBuildingEvaluationTreeTests : XCTestCase

@property(nonatomic, strong) PCParser *parser;

@end

@implementation PCBuildingEvaluationTreeTests

- (void)setUp {
    [super setUp];
    self.parser = [[PCParser alloc] init];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBuildingEvaluatingTree {
    NSString *mathString = @"3+(2+1)+1";
    NSError *error;
    NSArray *tokensArray = [self.parser tokenizeString:mathString error:&error];
    
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


@end
