//
//  MemoryManagementController.m
//  MyFood
//
//  Created by qunlee on 16/8/23.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "MemoryManagementController.h"
#import "Person.h"
#import "EQXColor.h"

@interface MemoryManagementController (){
    Person *_person;
}
@property (nonatomic, copy) Person *person;

@end

@implementation MemoryManagementController

- (void)dealloc{
    _delegate = nil;
    [_person release];
    [super dealloc];
}
- (void)setPerson:(Person *)person{
    if (person != _person) {
        [_person release];
        _person = person;
        _person = [person retain];
    }
}
- (Person *)person{
    return _person;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [EQXColor colorWithHexString:@"#f8f8f8"];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    if (_doDuff) {
        _doDuff(@"view show success");
    }
}

@end
