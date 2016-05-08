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

@interface PCTokenizationTests : XCTestCase

@end

@implementation PCTokenizationTests

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

- (void)testTokenizeSimpleMultiplicationOperation {
    NSString *mathString = @"1*2";
    
    PCParser *parser = [[PCParser alloc] init];
    NSArray *result = [parser tokenizeString:mathString];
    
    XCTAssertEqual(result.count, 3);
    XCTAssertEqual([result[1] isKindOfClass:[PCMultiplicationOperationToken class]], YES);
}

- (void)testTokenizeStringWithManyOperationsAndGrouping {
    NSString *mathString = @"3-(1+2)+4";
    
    PCParser *parser = [[PCParser alloc] init];
    NSArray *result = [parser tokenizeString:mathString];
    PCGroupToken *groupToken = result[2];
    
    XCTAssertEqual(result.count, 5);
    XCTAssertEqual(groupToken.groupedTokens.count, 3);
}

@end
