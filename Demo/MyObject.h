//
//  MyObject.h
//  JOEModelManager
//
//  Created by Joseph Collins on 2/17/14.
//  Copyright (c) 2014 Joseph Collins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyObject : NSObject <NSCoding>

@property (nonatomic, copy) NSString *text;

- (instancetype)initWithText:(NSString *)text;

@end
