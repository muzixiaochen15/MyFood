//
//  ListTestViewController.m
//  MyFood
//
//  Created by qunlee on 16/8/29.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "ListTestViewController.h"
#import "TestListCell.h"
#import "EQXColor.h"
#import "PureLayout/PureLayout.h"
#import "StringsClass.h"
#import "SLinkList.h"

@interface ListTestViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) UITableView *listTableView;
@end

@implementation ListTestViewController
//view为nil时调用
- (void)loadView{
    [super loadView];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[EQXColor colorWithHexString:@"#f8f8f8"]];
    
    [self addTalbeView];
    //[self c_codeTest];
}
#pragma mark - c code
- (void)c_codeTest{
    ListNode *h;//h指向结构体NODE
    int i = 1, n, score;
    char name [10];
    
    while ( i )
    {
        /*输入提示信息*/
        printf("1--建立新的链表\n");
        printf("2--添加元素\n");
        printf("3--删除元素\n");
        printf("4--输出当前表中的元素\n");
        printf("0--退出\n");
        
        scanf("%d",&i);
        switch(i)
        {
            case 1:
                printf("n=");   /*输入创建链表结点的个数*/
                scanf("%d",&n);
                h=CreateList(n);/*创建链表*/
                printf("list elements is : \n");
                PrintList(h);
                break;
                
            case 2:
                printf("input the position. of insert element:");
                scanf("%d",&i);
                printf("input name of the student:");
                scanf("%s",name);
                printf("input score of the student:");
                scanf("%d",&score);
                InsertList(h, i, name, score, name);
                printf("list elements is:\n");
                PrintList(h);
                break;
                
            case 3:
                printf("input the position of delete element:");
                scanf("%d",&i);
                DeleteList(h, i, n);
                printf("list elements in : \n");
                PrintList(h);
                break;
                
            case 4:
                printf("list element is : \n");
                PrintList(h);
                break;
            case 0:
                return;
                break;
            default:
                printf("ERROR!Try again!\n");
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewController = [self viewControllerForRowAtIndexPath:indexPath];
    viewController.title = [self titleForRowAtIndexPath:indexPath];
    [self testShowWithViewController:viewController];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController
                                         animated:YES];
}
- (void)testShowWithViewController:(UIViewController *)viewController{
#if 0
    if ([viewController isKindOfClass:[ListTestViewController class]]) {
        UIViewController *vc = (ListTestViewController *)viewController;
        __weak UIViewController *weakSelf = self;
        vc.doDuff = ^(NSString *string){
            if (weakSelf) {
                NSLog(@"%@", string);
                if (weakSelf) {
                    self.testObject = string;
                    [weakSelf.navigationController.navigationBar.topItem setTitle:string];
                }
            }
        };
    }
#endif
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}
//UIProgressView在cell中改变TintColor时，需要采用Appearance方式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TestListCell class])
                                                              forIndexPath:indexPath];
    cell.listTitleLabel.text = [self.items[indexPath.row] firstObject];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    [[UIProgressView appearance] setProgressTintColor:[EQXColor colorWithHexString:@"#50b440"]];
    cell.proview.progress = 0.01;
    return cell;
}
- (void)addTalbeView{
    self.items = @[@[@"字体", [UIViewController class]],
                   @[@"场景列表", [UIViewController class]],
                   @[@"GCD", [UIViewController class]],
                   @[@"Sqlite", [UIViewController class]],
                   @[@"Photo", [UIViewController class]],
                   @[@"Memory manageMent", [UIViewController class]],
                   @[@"tabview_test", [UIViewController class]]
                   ];
    self.listTableView = [UITableView newAutoLayoutView];
    [self.listTableView registerClass:[TestListCell class]
           forCellReuseIdentifier:NSStringFromClass([TestListCell class])];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.listTableView.rowHeight = 50.f;
    [self.view addSubview:self.listTableView];
    [self.listTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
}
- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.items[indexPath.row] firstObject];
}
- (UIViewController *)viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.items[indexPath.row] lastObject] new];
}

@end
