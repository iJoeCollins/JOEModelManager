//
//  MyObject.m
//  JOEModelManager
//
//  Created by Joseph Collins on 2/17/14.
//  Copyright (c) 2014 Joseph Collins. All rights reserved.
//

#import "MyObject.h"

/* NSCoding keys for MyObject
 */
static NSString * const kTextKey = @"kTextKey";


@implementation MyObject

#pragma mark - Initializer

- (instancetype)initWithText:(NSString *)text
{
    if (self = [super init]) {
        _text = text;
    }
    
    return self;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _text = [coder decodeObjectOfClass:[NSString class] forKey:kTextKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_text forKey:kTextKey];
}

@end
