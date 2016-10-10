//
//  SqliteViewController.m
//  MyFood
//
//  Created by qunlee on 16/8/19.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "SqliteViewController.h"
#import "EQXColor.h"
#import <FMDB/FMDB.h>
#import "WordItem.h"
#import <PureLayout/PureLayout.h>
#import "WordCell.h"
#import "WordDetailViewController.h"

@interface SqliteViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) FMDatabase *dataBase;

@property (nonatomic, strong) NSMutableArray *words;

@property (nonatomic, strong) UITableView *tableView;

@end


@implementation SqliteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClicked:)]];
    _words = [[NSMutableArray alloc]init];
    [self.view setBackgroundColor:[EQXColor colorWithHexString:@"#f8f8f8"]];
    __weak __typeof(self) weakSelf = self;
    if ([self queryData]) {
        [weakSelf.tableView reloadData];
    }else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (weakSelf) {
                [weakSelf readWords];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weakSelf) {
                    [weakSelf createAndInsertSql];
                    [weakSelf.tableView reloadData];
                }
            });
        });
    }
}
- (void)rightButtonClicked:(id)sender{
    [_tableView setEditing:!_tableView.editing animated:YES];
}
#pragma mark
#pragma mark - tableview
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView newAutoLayoutView];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WordCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([WordCell class])];
        [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _words.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WordCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WordCell class]) forIndexPath:indexPath];
    WordItem *item = _words[indexPath.row];
    cell.wordNameLabel.text = item.enText;
    cell.descripLabel.text = item.cnText;
    return cell;
}
#pragma mark - datasource
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
   //移动
    if (sourceIndexPath != destinationIndexPath) {
        WordItem *item = _words[sourceIndexPath.row];
        [tableView beginUpdates];
        [_words removeObjectAtIndex:sourceIndexPath.row];
        [_words insertObject:item atIndex:destinationIndexPath.row];
        [tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
        [tableView endUpdates];
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
#pragma mark - delegate
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"标题";
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    return @[[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (weakSelf) {
            [self editCellWithIndexPath:indexPath];
        }
    }], [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (weakSelf) {
            [weakSelf deleteCellWithIndexPath:indexPath];
        }
    }], [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"添加一行" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (weakSelf) {
            [weakSelf addCellWithIndexPath:indexPath];
        }
    }]];
}
- (void)addCellWithIndexPath:(NSIndexPath *)indexPath{
    [_words addObject:[[WordItem alloc]init]];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
    [_tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
}
- (void)editCellWithIndexPath:(NSIndexPath *)indexPath{
    WordItem *item = _words[indexPath.row];
    WordDetailViewController *wordDetailVC = [[WordDetailViewController alloc]init];
    wordDetailVC.wordName = item.enText;
    wordDetailVC.wordDetail = item.cnText;
    [self.navigationController pushViewController:wordDetailVC animated:YES];
}
- (void)deleteCellWithIndexPath:(NSIndexPath *)indexPath{
    [_words removeObjectAtIndex:indexPath.row];
    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark
#pragma mark - data
- (void)readWords{
    NSError *error;
    NSString *thepath = [[NSBundle mainBundle]pathForResource:@"computerwords" ofType:@"txt"] ;
    
    NSString *text = [NSString stringWithContentsOfFile:thepath encoding:NSUTF8StringEncoding error:&error];
    NSArray *array = [text componentsSeparatedByString:@"\n"];
    [array enumerateObjectsUsingBlock:^(NSString   * _Nonnull string, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *subArray = [string componentsSeparatedByString:@"#"];
        if (subArray.count > 1) {
            WordItem *item = [[WordItem alloc]init];
            item.enText = subArray[0];
            item.cnText = subArray[1];
            [_words addObject:item];
        }else if(subArray.count == 1){
            WordItem *item = [[WordItem alloc]init];
            item.enText = subArray[0];
            item.cnText = @"标题";
            [_words addObject:item];
        }
    }];
}
- (void)createAndInsertSql{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"computer words.sqlite"];
    _dataBase = [FMDatabase databaseWithPath:path];
    BOOL isOpen = [_dataBase open];
    if (isOpen) {
        NSString *sqlStr = @"create table if not exists wordListTable(en_text varchar, cn_text varchar)";
        BOOL isCreate = [_dataBase executeUpdate:sqlStr];
        if (isCreate) {
            NSString *delete = @"delete from wordListTable";
            //先删除
            [_dataBase executeUpdate:delete];
            for (WordItem *item in _words) {
                [_dataBase executeUpdate:@"insert into wordListTable(en_text, cn_text) values (?, ?)", item.enText, item.cnText];
            }
        }
        [_dataBase close];
    }
}
- (BOOL)queryData{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"computer words.sqlite"];
    _dataBase = [FMDatabase databaseWithPath:path];
    if ([_dataBase open]) {
        FMResultSet *rs = [_dataBase executeQuery:@"select * from wordListTable"];
        while ([rs next]) {
            WordItem *item = [[WordItem alloc]init];
            item.enText = [rs stringForColumn:@"en_text"];
            item.cnText = [rs stringForColumn:@"cn_text"];
            [_words addObject:item];
        }
        [_dataBase close];
    }
    if ([_words count] > 0) {
        return YES;
    }else{
        return NO;
    }
}

@end
