//
//  TestTabviewController1.m
//  MyFood
//
//  Created by qunlee on 16/9/19.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "IOSReflectionTabviewController.h"
#import "ObjectClass.h"

@implementation IOSReflectionTabviewController

- (void)viewDidLoad{
    [super viewDidLoad];
    NSArray *array = [MFConstClass getPropertiesOfObject:[[ObjectClass alloc]init]];
    NSLog(@"array = %@", array);
    
    NSArray *varArray = [MFConstClass getVariableNameOfObject:[[ObjectClass alloc]init]];
    
    NSLog(@"var_array = %@", varArray);
}

@end
