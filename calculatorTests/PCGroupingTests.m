//
//  PCGroupingTests.m
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

@interface PCGroupingTests : XCTestCase

@property(nonatomic, strong) PCParser *parser;

@end

@implementation PCGroupingTests

- (void)setUp {
    [super setUp];
    self.parser = [[PCParser alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSimpleGrouping {
    NSString *mathString = @"3+1";
    NSError *error;
    NSArray *tokensArray = [self.parser tokenizeString:mathString error:&error];
    
    PCGrouper *grouper = [[PCGrouper alloc] init];
    NSArray *groupingResult = [grouper groupAllTokensInArray:tokensArray];
    PCGroupToken *groupedToken1lvl = groupingResult.firstObject;
    PCNumberToken *groupedToken2lvl1 = groupedToken1lvl.groupedTokens[0];
    PCAddOperatorToken *groupedToken2lvl2 = groupedToken1lvl.groupedTokens[1];
    PCNumberToken *groupedToken2lvl3 = groupedToken1lvl.groupedTokens[2];
    
    XCTAssertEqual(groupingResult.count, 1);
    XCTAssertEqual([groupedToken1lvl isKindOfClass:[PCGroupToken class]], YES);
    XCTAssertEqual([groupedToken2lvl1 isKindOfClass:[PCNumberToken class]], YES);
    XCTAssertEqual([groupedToken2lvl2 isKindOfClass:[PCAddOperatorToken class]], YES);
    XCTAssertEqual([groupedToken2lvl3 isKindOfClass:[PCNumberToken class]], YES);
}

- (void)testGroupingWithGroup {
    NSString *mathString = @"3+(2+1)+1";
    NSError *error;
    NSArray *tokensArray = [self.parser tokenizeString:mathString error:&error];
    
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

- (void)testGroupingWithDifferentPrecedence {
    NSString *mathString = @"1+2*3+4";
    NSError *error;
    NSArray *tokensArray = [self.parser tokenizeString:mathString error:&error];
    
    PCGrouper *grouper = [[PCGrouper alloc] init];
    NSArray *groupingResult = [grouper groupAllTokensInArray:tokensArray];
    PCGroupToken *groupedToken1lvl = groupingResult.firstObject;
    PCGroupToken *groupedToken2lvl = groupedToken1lvl.groupedTokens.firstObject;
    PCGroupToken *groupedToken3lvl = groupedToken2lvl.groupedTokens.lastObject;
    PCOperatorToken *operationToken4lvl = groupedToken3lvl.groupedTokens[1];
    
    XCTAssertEqual([groupedToken1lvl isKindOfClass:[PCGroupToken class]], YES);
    XCTAssertEqual([groupedToken2lvl isKindOfClass:[PCGroupToken class]], YES);
    XCTAssertEqual([groupedToken3lvl isKindOfClass:[PCGroupToken class]], YES);
    XCTAssertEqual([operationToken4lvl isKindOfClass:[PCMultiplicationOperationToken class]], YES);
}

@end
