//
//  PCTokenizationTests.m
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
#import "PCDivisionOperatorToken.h"

@interface PCTokenizationTests : XCTestCase

@property(nonatomic, strong) PCParser *parser;

@end

@implementation PCTokenizationTests

- (void)setUp {
    [super setUp];
    self.parser = [[PCParser alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTokenizerReturnsNoError {
    NSString *mathString = @"1+7";
    
    NSError *error;
    NSArray *result = [self.parser tokenizeString:mathString error:&error];
    
    XCTAssertNotNil(result);
}

- (void)testTokenizerReturnsErrorIfIncorrectSymbol {
    NSString *mathString = @"д";
    
    NSError *error;
    NSArray *result = [self.parser tokenizeString:mathString error:&error];
    
    XCTAssertNil(result);
    XCTAssertNotNil(error);
}

- (void)testTokenizerReturnsErrorIfBadFormat {
    NSString *mathString = @"1***2";
    
    NSError *error;
    NSArray *result = [self.parser tokenizeString:mathString error:&error];
    
    XCTAssertNil(result);
    XCTAssertNotNil(error);
}

- (void)testTokenizerReturnsErrorIfParenthesisIsMissing {
    NSString *mathString = @"(1+2";
    
    NSError *error;
    NSArray *result = [self.parser tokenizeString:mathString error:&error];
    
    XCTAssertNil(result);
    XCTAssertNotNil(error);
}

- (void)testTokenizeSingleFloatNumber {
    NSString *mathString = @"33.456";
    
    NSError *error;
    NSArray *result = [self.parser tokenizeString:mathString error:&error];
    PCNumberToken *resultToken = result.firstObject;
    
    XCTAssertNotNil(result);
    XCTAssertEqual(result.count, 1);
    XCTAssertEqual([result.firstObject isKindOfClass:[PCNumberToken class]], YES);
    XCTAssertEqual([resultToken getValue].floatValue, @(33.456).floatValue);
}

- (void)testTokenizeGrouping {
    NSString *mathString = @"(1+2)";
    
    NSError *error;
    NSArray *result = [self.parser tokenizeString:mathString error:&error];
    PCGroupToken *resultToken = result.firstObject;
    
    XCTAssertEqual(result.count, 1);
    XCTAssertEqual([result.firstObject isKindOfClass:[PCGroupToken class]], YES);
    XCTAssertEqual([resultToken.mnemonic isEqualToString:@"1+2"], YES);
}

- (void)testTokenizeSimpleAddOperation {
    NSString *mathString = @"1+2";
    
    NSError *error;
    NSArray *result = [self.parser tokenizeString:mathString error:&error];
    
    XCTAssertEqual(result.count, 3);
    XCTAssertEqual([result[1] isKindOfClass:[PCAddOperatorToken class]], YES);
}

- (void)testTokenizeSimpleSubstractOperation {
    NSString *mathString = @"1-2";
    
    NSError *error;
    NSArray *result = [self.parser tokenizeString:mathString error:&error];
    
    XCTAssertEqual(result.count, 3);
    XCTAssertEqual([result[1] isKindOfClass:[PCSubstractOperatorToken class]], YES);
}

- (void)testTokenizeSimpleDivisionOperation {
    NSString *mathString = @"4/2";
    
    NSError *error;
    NSArray *result = [self.parser tokenizeString:mathString error:&error];
    
    XCTAssertEqual(result.count, 3);
    XCTAssertEqual([result[1] isKindOfClass:[PCDivisionOperatorToken class]], YES);
}

- (void)testTokenizeSimpleMultiplicationOperation {
    NSString *mathString = @"1*2";
    
    NSError *error;
    NSArray *result = [self.parser tokenizeString:mathString error:&error];
    
    XCTAssertEqual(result.count, 3);
    XCTAssertEqual([result[1] isKindOfClass:[PCMultiplicationOperationToken class]], YES);
}

- (void)testTokenizeStringWithManyOperationsAndGrouping {
    NSString *mathString = @"3-(1+2)+4";
    
    NSError *error;
    NSArray *result = [self.parser tokenizeString:mathString error:&error];
    PCGroupToken *groupToken = result[2];
    
    XCTAssertEqual(result.count, 5);
    XCTAssertEqual(groupToken.groupedTokens.count, 3);
}

@end
