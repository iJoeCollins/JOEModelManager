//
//  JOEModelManager.m
//
//  Version 0.1.0
//
//  Created by Joseph Collins on 1/22/14.
//
//  Distributed under The MIT License (MIT)
//  Get the latest version here:
//
//  http://www.github.com/ijoecollins/JOEModelManager
//
//  Copyright (c) 2014 Joseph Collins.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "JOEModelManager.h"

NSString *const JOEModelManagerDidSaveNotification = @"JOEModelManagerDidSaveNotification";
NSString *const JOEModelManagerDidSaveUserInfoKey = @"JOEModelManagerDidSaveUserInfoKey";

@interface JOEModelManager ()

@property (strong, nonatomic) NSMutableArray *sharedModel;
@property (strong, nonatomic) id currentObject;

@end

@implementation JOEModelManager

#pragma mark - Initializers and Lifetime Management

static JOEModelManager *sharedManager = nil;

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[JOEModelManager alloc] init];
    });
    
    return sharedManager;
}


- (instancetype)init
{
    if ((self = [super init])) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationWillTerminateNotification object:nil];
    }
    
    return self;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Insertion and Deletion

- (void)addObject:(id)object
{
    if (_sharedModel == nil) {
        self.sharedModel = [NSMutableArray array];
    }
    
    [_sharedModel addObject:object];
}


- (void)removeObject:(id)object
{
    if ([_sharedModel count]) {
        [_sharedModel removeObject:object];
    }
}


- (void)insertObject:(id)object atIndex:(NSUInteger)index
{
    if (_sharedModel == nil) {
        self.sharedModel = [NSMutableArray array];
    }
    
    [_sharedModel insertObject:object atIndex:index];
}


- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object
{
    if ([_sharedModel count]) {
        [_sharedModel replaceObjectAtIndex:index withObject:object];
    }
}


- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2
{
    if ([_sharedModel count]) {
        [_sharedModel exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
    }
}

#pragma mark - Object Retrieval

- (id)objectAtIndex:(NSUInteger)index
{
    self.currentObject = [_sharedModel objectAtIndex:index];
    
    return self.currentObject;
}

#pragma mark - Model Loading and Saving

- (BOOL)load
{
    if ((_sharedModel != nil)) {
        return YES;
    }
    
    self.sharedModel = [NSKeyedUnarchiver unarchiveObjectWithFile:[self modelPath]];
    
    BOOL modelExists = (_sharedModel != nil);
    
    if (!modelExists) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:[self modelDirectory] withIntermediateDirectories:YES attributes:nil error:&error];
        NSAssert(error == nil, @"Failed to create directory with error %@", error);
    }
    
    return modelExists;
}


- (BOOL)save
{
    if(_sharedModel == nil) {
        return NO;
    }
    
    BOOL success = [NSKeyedArchiver archiveRootObject:self.sharedModel toFile:[self modelPath]];
    NSAssert(success, @"Error archiving data path: %@", [self modelPath]);
    
    // Post notification indicating success
    [[NSNotificationCenter defaultCenter] postNotificationName:JOEModelManagerDidSaveNotification object:nil userInfo:@{JOEModelManagerDidSaveUserInfoKey: @(success)}];
    
    return success;
}

#pragma mark - Model Directory and Path

/*! Returns the path to the application's data model directory.
 */
- (NSString *)modelDirectory
{
    NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    return [docsPath stringByAppendingPathComponent:@"Application Data"];
}

/*! Returns the path to the application's data model.
 */
- (NSString *)modelPath
{
    return [[self modelDirectory] stringByAppendingPathComponent:@"data.plist"];
}

@end
