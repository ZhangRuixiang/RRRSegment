# RRRSegment
支持自动滑动到中间 

这是一个SegmentControl 

并且有点击事件 

直接上图：![](https://github.com/ZhangRuixiang/RRRSegment/raw/master/shot1.png)

#usage
```
 RRRSegment *segment = [[RRRSegment alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 30)];
    
    
    segment.backgroundColor = [UIColor orangeColor];
    segment.selectedTextColor = [UIColor redColor];
    segment.isShowUnderline = YES;
    
    segment.tapItemWithIndex = ^(NSInteger index,BOOL animation){
        
        NSLog(@"****点击了第%ld个 item****",(long)index);
    };
    
    
    [self.view addSubview:segment];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 10; i ++) {
        
        [arr addObject:[NSString stringWithFormat:@"item%d",i]];
        
    }
    segment.titleArray = [NSArray arrayWithArray:arr];
 
```
