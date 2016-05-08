//
//  PCTokenCharacterBuffer.h
//  calculator
//
//  Created by Pavel Ivanov on 07/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCTokenCharacterBuffer : NSObject

@property (nonatomic, assign) NSUInteger currentIndex;

+(instancetype)initWithString:(NSString*)string;
-(void)peekNextCharacters:(NSInteger)delta;
-(void)consumeCharacters:(NSInteger)delta;

@end
