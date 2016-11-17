//
//  AddressListViewController.m
//  MyFood
//
//  Created by qunlee on 16/11/11.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "AddressListViewController.h"
#import "EQXColor.h"
#import <AddressBookUI/ABPeoplePickerNavigationController.h>
#import <AddressBook/ABPerson.h>
#import <AddressBookUI/ABPersonViewController.h>
#import "CommonDefine.h"
#import "AViewController.h"

@interface AddressListViewController ()<ABPersonViewControllerDelegate, ABPeoplePickerNavigationControllerDelegate>

@end

@implementation AddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[EQXColor colorWithHexString:@"#f8f8f8"]];
    return;
    ABPeoplePickerNavigationController *abNav = [[ABPeoplePickerNavigationController alloc]init];
    abNav.peoplePickerDelegate = self;
    if ([getAppVersion() floatValue] >= 8.0f ) {
        abNav.predicateForEnablingPerson = [NSPredicate predicateWithValue:false];
    }
    [self presentViewController:abNav animated:YES completion:nil];
    
    ABAddressBookRef *abBookRef = ABAddressBookCreateWithOptions(nil, nil);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self presentViewController:[[AViewController alloc]init] animated:YES completion:nil];
}
//取消选择
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#if 0
- (void)getAddressBossAuthorizationStatus{
    switch (ABAddressBookGetAuthorizationStatus()) {//IOS9
            /*
             kABAuthorizationStatusNotDetermined = 0,    // deprecated, use CNAuthorizationStatusNotDetermined
             kABAuthorizationStatusRestricted,           // deprecated, use CNAuthorizationStatusRestricted
             kABAuthorizationStatusDenied,               // deprecated, use CNAuthorizationStatusDenied
             kABAuthorizationStatusAuthorized
             */
        case kABAuthorizationStatusNotDetermined:
        case kABAuthorizationStatusRestricted:
        {
            
        }
            break;
        case kABAuthorizationStatusDenied:
        {
            
        }
            break;
        case kABAuthorizationStatusAuthorized:
        {
            
        }
            break;
        default:
            break;
    }
}
#endif
#pragma mark - ios 8
- (void)getAddressBossAuthorizationStatus{
    switch (ABAddressBookGetAuthorizationStatus()) {
            /*
             kABAuthorizationStatusNotDetermined = 0,    // deprecated, use CNAuthorizationStatusNotDetermined
             kABAuthorizationStatusRestricted,           // deprecated, use CNAuthorizationStatusRestricted
             kABAuthorizationStatusDenied,               // deprecated, use CNAuthorizationStatusDenied
             kABAuthorizationStatusAuthorized
             */
        case kABAuthorizationStatusNotDetermined:
        case kABAuthorizationStatusRestricted:
        {
            
        }
            break;
        case kABAuthorizationStatusDenied:
        {
            
        }
            break;
        case kABAuthorizationStatusAuthorized:
        {
            
        }
            break;
        default:
            break;
    }
}
#pragma mark - ios 8 以下
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
    
    if ([phoneNO hasPrefix:@"+"]) {
        phoneNO = [phoneNO substringFromIndex:3];
    }
    
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSLog(@"%@", phoneNO);
//    if (phone && [ZXValidateHelper checkTel:phoneNO]) {
//        phoneNum = phoneNO;
//        [self.tableView reloadData];
//        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
//        return;
//    }
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person
{
    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
    personViewController.displayedPerson = person;
    [peoplePicker pushViewController:personViewController animated:YES];
}
#pragma mark - ios7 以下
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
    if ([phoneNO hasPrefix:@"+"]) {
        phoneNO = [phoneNO substringFromIndex:3];
    }
    
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSLog(@"%@", phoneNO);
//    if (phone && [ZXValidateHelper checkTel:phoneNO]) {
//        phoneNum = phoneNO;
//        [self.tableView reloadData];
//        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
//        return NO;
//    }
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
