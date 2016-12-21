//
//  ViewController.m
//  RRRSegmentDemo
//
//  Created by 张瑞想 on 2016/12/20.
//  Copyright © 2016年 张瑞想. All rights reserved.
//

#import "ViewController.h"
#import "RRRSegment.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    RRRSegment *segment = [[RRRSegment alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 30)];
    

    segment.backgroundColor = [UIColor orangeColor];
    segment.selectedTextColor = [UIColor redColor];
    segment.isShowUnderline = YES;
    
    /**
     Block的定义格式
     返回值类型(^block变量名)(形参列表) = ^(形参列表) {
     };
     */
    segment.tapItemWithIndex = ^(NSInteger index,BOOL animation){
    
        NSLog(@"****点击了第%ld个 item****",(long)index);
    };
    

    [self.view addSubview:segment];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 10; i ++) {
        
        [arr addObject:[NSString stringWithFormat:@"item%d",i]];
        
    }
    segment.titleArray = [NSArray arrayWithArray:arr];

}


@end
