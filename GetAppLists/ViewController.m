//
//  ViewController.m
//  GetAppLists
//
//  Created by ashen on 16/12/29.
//  Copyright © 2016年 Ashen. All rights reserved.
//

#import "ViewController.h"
#import "GetAppLists.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) UITableView * tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 30, [UIScreen mainScreen].bounds.size.width - 40, [UIScreen mainScreen].bounds.size.height - 30) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    GetAppLists *list = [[GetAppLists alloc]init];
    _dataSource = [list getAppLists];
    [self.view addSubview:_tableView];
    [_tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"idenCell"];
    if (cell == nil) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"idenCell"];
    }
    cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
    cell.textLabel.numberOfLines = 0;
    NSString *searchText = [NSString stringWithFormat:@"%@", _dataSource[indexPath.row]];
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<.+?> (.+?) .+?" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *results = [regex matchesInString:searchText options:0 range:NSMakeRange(0, [searchText length])];
    NSString * str = @"";
    
    for (NSTextCheckingResult * r in results) {
       str = [searchText substringWithRange:[r rangeAtIndex:1]];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld %@", indexPath.row + 1, str];
    return cell;
    
}


@end
