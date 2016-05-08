//
//  PCToken.h
//  calculator
//
//  Created by Pavel Ivanov on 07/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCToken : NSObject

@property (nonatomic, strong) NSArray *childs;
@property (nonatomic, strong) NSString *kind;

@end
