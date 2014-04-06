//
//  ViewController.h
//  JOEModelManager
//
//  Created by Joseph Collins on 4/6/14.
//  Copyright (c) 2014 Joseph Collins. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyObject;

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) MyObject *myObject;

@end
