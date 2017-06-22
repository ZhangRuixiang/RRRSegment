//
//  ViewController.m
//  RRRSegmentDemo
//
//  Created by 张瑞想 on 2016/12/21.
//  Copyright © 2016年 张瑞想. All rights reserved.
//

#import "ViewController.h"
#import "RRRSegment.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kSegmentHeight          30
#define kStatusBarHeight        ([[UIApplication sharedApplication] statusBarFrame].size.height)

@interface ViewController () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) RRRSegment *segment;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat spaceX = 0.0;
    CGFloat spaceY = kStatusBarHeight;
    
    RRRSegment *segment = [[RRRSegment alloc] initWithFrame:CGRectMake(spaceX, spaceY, SCREEN_WIDTH, kSegmentHeight)];
    _segment = segment;
    
    spaceY += kSegmentHeight;
    
    // 配置
    segment.backgroundColor = [UIColor orangeColor];
    segment.textColor = [UIColor whiteColor];
    segment.selectedTextColor = [UIColor redColor];
    segment.isShowUnderline = YES;
    
    /**
     Block的定义格式
     返回值类型(^block变量名)(形参列表) = ^(形参列表) {
     };
     */
    
    __weak __typeof(self) wself = self;
    segment.tapItemWithIndex = ^(NSInteger index){
        NSLog(@"****点击了第%ld个 item****",(long)index);
        [wself.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, 0) animated:YES];
    };
    
    [self.view addSubview:segment];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 10; i ++) {
        [arr addObject:[NSString stringWithFormat:@"item%d",i]];
    }
    segment.titleArray = [NSArray arrayWithArray:arr];
    
    // scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(spaceX, spaceY, SCREEN_WIDTH, SCREEN_HEIGHT - spaceY)];
    _scrollView = scrollView;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*segment.titleArray.count, SCREEN_HEIGHT - spaceY);
    [self.view addSubview:scrollView];
    
    // tableView
    for (int i = 0; i < segment.titleArray.count; i ++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(i *SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - spaceY) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = i;
        tableView.backgroundColor = [UIColor colorWithRed:236/255.0f green:237/255.0f blue:243/255.0f alpha:1.0];
        [self.scrollView addSubview:tableView];
    }
}

#pragma mark - 代理方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        CGFloat offset = scrollView.contentOffset.x;
        offset = offset / CGRectGetWidth(scrollView.frame);
        [_segment endMoveToIndex:offset];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const ID = @"cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"tableView %ld 的第 %ld 行", tableView.tag, indexPath.row];
    return cell;
}


@end
