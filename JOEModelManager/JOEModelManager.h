//
//  JOEModelManager.h
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

#import <Foundation/Foundation.h>

/*! Notification sent when the model manager commits a save. The userInfo dictionary contains a NSNumber indicating success.
*/

extern NSString *const JOEModelManagerDidSaveNotification;

/*! User info dictionary key for the JOEModelManagerDidSaveNotification.
*/

extern NSString *const JOEModelManagerDidSaveUserInfoKey;

/*! Simple data storage manager using NSCoding for persistance to disk.
*/

@interface JOEModelManager : NSObject


///-------------------------------
/// @name Creating JOEModelManager
///-------------------------------

/*! This method allocates and initializes the singleton manager object if one doesn’t already exist.
 
    @return The shared manager instance.
*/

+ (instancetype)sharedManager;


///-------------------------------
/// @name Insertion and Deletion
///-------------------------------

/*! Inserts a given object at the end of the shared model.
 
    @param object The object to be added to the model.
*/

- (void)addObject:(id)object;

/*! Removes all occurrences of an object in the shared model.
 
    @param object The object to be removed from the model.
*/

- (void)removeObject:(id)object;

/*! Inserts a given object into the shared model manager's contents at a given index.
    If index is already occupied, the objects at index and beyond are shifted by adding 1 to their
    indices to make room.
 
    @param object The object to be inserted at the given index.
    @param index  The index at which the object will be inserted.
*/

- (void)insertObject:(id)object atIndex:(NSUInteger)index;

/*! Replaces the object at index with anObject.
 
    @param index  The index of the object which will be replaced.
    @param object The object that will replace the one at the index. Should not be nil.
*/

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object;

/*! Exchanges the objects in the shared model at given indices.
 
    @param idx1 The index of the object with which to replace the object at index idx2.
    @param idx2 The index of the object with which to replace the object at index idx1.
*/

- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;


///-------------------------------
/// @name Object Retrieval
///-------------------------------

/*! Returns an object from the shared model at the given index
 
    @param index An index within the bounds of the array.
    @return The object located at index.
*/

- (id)objectAtIndex:(NSUInteger)index;


///-------------------------------
/// @name Model Loading and Saving
///-------------------------------

/*! Loads the shared object model from disk.
 
    @return If YES, it was a success the model is either already loaded or it was loaded from disk.
*/

- (BOOL)load;

/*! Saves the shared model to disk.
 
    @return If YES, it was a success and the model was saved.
*/

- (BOOL)save;

@end
