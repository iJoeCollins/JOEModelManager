//
//  ViewController.m
//  JOEModelManager
//
//  Created by Joseph Collins on 4/6/14.
//  Copyright (c) 2014 Joseph Collins. All rights reserved.
//

#import "ViewController.h"
#import "JOEModelManager.h"
#import "MyObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.label.text = self.myObject.text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *txt = [NSMutableString stringWithString:textField.text];
    [txt replaceCharactersInRange:range withString:string];
    self.label.text = txt;
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    
    // Update your object.
    self.myObject.text = textField.text;
    
    // Save your data.
    [[JOEModelManager sharedManager] save];
    
    return YES;
}

@end
