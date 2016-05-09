//
//  PCCalculatorTests.m
//  calculator
//
//  Created by Pavel Ivanov on 09/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PCCalculator.h"

@interface PCCalculatorTests : XCTestCase

@property (nonatomic, strong) PCCalculator *calculator;

@end

@implementation PCCalculatorTests

- (void)setUp {
    [super setUp];
    self.calculator = [[PCCalculator alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEvalMethod {
    NSString *mathString = @"1+2*3+4";
    NSError *error;
    
    NSNumber *result = [self.calculator evalString:mathString error:&error];
    
    XCTAssertNotNil(result);
    XCTAssertEqual([result isEqualToNumber:@(1+2*3+4)], YES);
}

@end
