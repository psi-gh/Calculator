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
@property (nonatomic, strong, readonly) NSString *originalString;

+(instancetype)initWithString:(NSString*)string;

-(NSString*)peekNextCharacters:(NSInteger)delta;
-(unichar)peekNextCharacter;
-(unichar)getCurrentCharacter;

-(void)consumeCharacters:(NSInteger)delta;
-(void)resetTo:(NSUInteger)index;

-(NSUInteger)endIndex;

@end
