//
//  JuHeTableViewController.m
//  MyFood
//
//  Created by qunlee on 16/9/14.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "JuHeTableViewController.h"
#import "FunnyItem.h"
#import "EQXRequest.h"
#import "MFConstUrlClass.h"
#import <PINCache/PINCache.h>
#import "JokeTableViewCell.h"
#import <PureLayout/PureLayout.h>
#import "EQXColor.h"

@interface JuHeTableViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) EQXRequest *request;

@end

@implementation JuHeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[EQXColor colorWithHexString:@"#f8f8f8"]];
    [self getRequest];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [EQXColor colorWithHexString:@"#e6e6e6"];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [self.view addSubview:_tableView];
        [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JokeTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([JokeTableViewCell class])];
        _currentOffsetY = _tableView.contentOffset.y;
    }
    return _tableView;
}
- (void)getRequest{
    _listArray = [[NSMutableArray alloc]init];
    NSUInteger pageNum = 0,pageSize = 100;
    NSString *url = [NSString stringWithFormat:@"%@%@?cat=%@&st=%lu&count=%lu&key=%@", JuHeIP, JuHeFunnyList, _listType, (unsigned long)pageNum, (unsigned long)pageSize, JuHeFunnyAppKey];
    __weak JuHeTableViewController *weakSelf = self;
    [[PINCache sharedCache]objectForKey:url block:^(PINCache * _Nonnull cache, NSString * _Nonnull key, id  _Nullable object) {
        //首次加载到数据
        if (object&&[object isKindOfClass:[NSDictionary class]]&&object[@"result"][@"data"] > 0) {
            if (weakSelf) {
                [weakSelf parseJsonToDicWithDic:object withUrl:url];
            }
            return ;
        }
        if (weakSelf) {
            [weakSelf.request requestWithUrl:url withRequestType:kRequestTypeGet withParameters:nil withFinishBlcok:^(NSDictionary *jsonDic) {
                if (weakSelf) {
                    [weakSelf parseJsonToDicWithDic:jsonDic withUrl:url];
                }
            }];
        }
    }];
    //NSURLErrorNotConnectedToInternet -1009连不上后台
}
- (void)parseJsonToDicWithDic:(NSDictionary *)dic withUrl:(NSString *)url{
    if (dic&&[dic isKindOfClass:[NSDictionary class]]) {
        [[PINCache sharedCache]setObject:dic forKey:url];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (dic[@"result"][@"data"] > 0) {
            [_listArray addObjectsFromArray:[MFConstClass parseListWithItemClassName:NSStringFromClass([FunnyItem class]) withList:dic[@"result"][@"data"]]];
            for (FunnyItem *item in _listArray) {
                [self addHeightParameterWithHeight:item];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}
- (void)addHeightParameterWithHeight:(FunnyItem *)item{
    item.approveNum = 8888;
    item.isApprove = YES;
    item.isDisapprove = NO;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10.0f;
    paragraphStyle.minimumLineHeight = 15.0f;
    paragraphStyle.maximumLineHeight = 15.0f;
    NSDictionary *attributes = @{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName: [UIFont fontWithName:@"FZY3K--GB1-0" size:15.0f], NSForegroundColorAttributeName: [EQXColor colorWithHexString:@"#686868"]};
    CGRect rect = [item.title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - (25.0f + 15.0f), CGFLOAT_MAX)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:attributes
                                          context:nil];
    NSAttributedString * subString = [[NSAttributedString alloc] initWithString:item.title attributes:attributes];
    item.titleAttr = subString;
    //额外+5.0f的高度
    item.titleHeight = rect.size.height + 65;
}
- (EQXRequest *)request{
    if (!_request) {
        _request = [[EQXRequest alloc]init];
    }
    return _request;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_listArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JokeTableViewCell *cell = (JokeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JokeTableViewCell class]) forIndexPath:indexPath];
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [EQXColor colorWithHexString:@"#e6e6e6"];
    FunnyItem *item = _listArray[indexPath.row];
    [cell updateCellWithItem:item];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    FunnyItem *item = _listArray[indexPath.row];
    return item.titleHeight;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.navigationController.navigationBarHidden&&scrollView.contentOffset.y - _currentOffsetY > 10.0f) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else if(self.navigationController.navigationBarHidden&&scrollView.contentOffset.y - _currentOffsetY < -10.0f){
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    _currentOffsetY = scrollView.contentOffset.y;
}
@end
