//
//  RXSegmentedControl.m
//  ZHStore
//
//  Created by 张瑞想 on 16/2/24.
//  Copyright © 2016年 zhanghetianxia. All rights reserved.
//

#import "RRRSegment.h"
#import <objc/runtime.h>


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface RRRSegment()

@property(nonatomic,strong)UIView *line;
@property (nonatomic, strong) NSMutableArray *btnArray;

@end


@implementation RRRSegment


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initConfig];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self initConfig];
    }
    return self;
}

- (void)initConfig
{
    _btnArray = [NSMutableArray array];
    
    _itemWidth = 60;
    _itemFont = [UIFont boldSystemFontOfSize:16];
    _textColor = [UIColor blackColor];
    _selectedTextColor = [UIColor redColor];
    _selectedBgColor = [UIColor whiteColor];
    _linePercent = 1.0;
    _lineHieght = 2.0;
    _lineColor = [UIColor redColor];
    _separatorColor = [UIColor whiteColor];
    
    
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.scrollsToTop = NO;
    self.tapAnimation = YES;
    self.isCanAutomaticallySlide = YES;
    self.isShowUnderline = NO;
    self.isShowBorderline = NO;
    self.isShowSeparatorline = NO;
    self.backgroundColor = [UIColor whiteColor];
}

static const char objcKey;

-(void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
    if(!self){

        return;
    }
    
    float x = 0;
    float y = 0;
    
    CGFloat lineMargin = 1.0f;
    float width = self.itemWidth;
    if (_isShowSeparatorline) {
        width = self.itemWidth - lineMargin;
    }
    float height = self.frame.size.height;
    
    for (int i=0; i<titleArray.count; i++) {
        
        x = self.itemWidth*i;
        
        // =======================================================================
        // UIButton
        // =======================================================================
        
        UIButton *btn = nil;
        
        if (_btnArray.count > i) {
            btn = _btnArray[i];
        }
        
        if (btn == nil) {
            btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
            objc_setAssociatedObject(btn, &objcKey, @(i), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [_btnArray addObject:btn];
        }
        
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:self.textColor forState:UIControlStateNormal];
        btn.titleLabel.font = self.itemFont;
        [btn addTarget:self action:@selector(itemButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        if(i == 0){
            btn.backgroundColor = self.selectedBgColor;
            [btn setTitleColor:self.selectedTextColor forState:UIControlStateNormal];
            btn.titleLabel.font = self.selectedItemFont;
            _currentIndex = 0;
            [self itemButtonClicked:btn];

            if (_isShowUnderline) {
                self.line = [[UIView alloc] initWithFrame:CGRectMake(self.itemWidth*(1-self.linePercent)/2.0, CGRectGetHeight(self.frame) - self.lineHieght, self.itemWidth*self.linePercent, self.lineHieght)];
                _line.backgroundColor = self.lineColor;
                [self addSubview:_line];
            }
        }
        
        // =======================================================================
        // 分割线
        // =======================================================================
        CGFloat lineMargin = 1.0f;

        if (_isShowSeparatorline) {
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = self.separatorColor;
            line.frame = CGRectMake(width, 0, lineMargin, btn.frame.size.height);
            [btn addSubview:line];
        }
     
        // =======================================================================
        // Border
        // =======================================================================
        if (_isShowBorderline) {
            UIView *lineTop = [[UIView alloc] init];
            lineTop.backgroundColor = self.separatorColor;
            lineTop.frame = CGRectMake(0, 0, width, lineMargin);
            [btn addSubview:lineTop];
            
            if (i == 0) {
                UIView *lineLeft = [[UIView alloc] init];
                lineLeft.backgroundColor = self.separatorColor;
                lineLeft.frame = CGRectMake(0, 0, lineMargin, btn.frame.size.height);
                [btn addSubview:lineLeft];
            }
            
            UIView *lineBottom = [[UIView alloc] init];
            lineBottom.backgroundColor = self.separatorColor;
            lineBottom.frame = CGRectMake(0, btn.frame.size.height - lineMargin, width, lineMargin);
            [btn addSubview:lineBottom];
        }
        
    }
    
    self.contentSize = CGSizeMake(width*titleArray.count, height);
}


#pragma mark - 点击事件

-(void)itemButtonClicked:(UIButton*)btn
{

    //接入外部效果
    NSNumber *index = objc_getAssociatedObject(btn, &objcKey);
    _currentIndex = [index integerValue];
    [self changeItemColor:_currentIndex];
    [self changeLine:_currentIndex];
    
    
    
//    if(_tapAnimation){
//        
//        //有动画，由call is scrollView 带动线条，改变颜色
//        
//        [self changeItemColor:_currentIndex];
//        [self changeLine:_currentIndex];
//        
//    }else{
//        
//        //没有动画，需要手动瞬移线条，改变颜色
//        [self changeItemColor:_currentIndex];
//        [self changeLine:_currentIndex];
//    }
    
    
    
    
    // 滑动
    if (_isCanAutomaticallySlide) {
        
        if ((_titleArray.count * self.itemWidth) >= SCREEN_WIDTH) {
            [self changeScrollOfSet:_currentIndex];
        }
        
    }
    
    
    if(self.tapItemWithIndex){
        _tapItemWithIndex(_currentIndex,_tapAnimation);
    }
    
    
}


#pragma mark - Methods

//改变文字焦点
-(void)changeItemColor:(NSInteger)index
{
    for (int i=0; i<_titleArray.count; i++) {
        if (_btnArray.count <= i) {
            return;
        }
        UIButton *btn = (UIButton*)[self.btnArray objectAtIndex:i];
        [btn setTitleColor:self.textColor forState:UIControlStateNormal];
        NSNumber *btnIndex = objc_getAssociatedObject(btn, &objcKey);

        if([btnIndex integerValue] == index){
            btn.backgroundColor = self.selectedBgColor;
            btn.titleLabel.font = self.selectedItemFont;
            [btn setTitleColor:self.selectedTextColor forState:UIControlStateNormal];

        } else {
            btn.backgroundColor = self.backgroundColor;
            btn.titleLabel.font = self.itemFont;
        }
    }
    
}

//改变线条位置
-(void)changeLine:(float)index
{
    CGRect rect = _line.frame;
    rect.origin.x = index*self.itemWidth + self.itemWidth*(1-self.linePercent)/2.0;
    _line.frame = rect;
    [self bringSubviewToFront:_line];
}


//向上取整
//- (NSInteger)changeProgressToInteger:(float)x
//{
//    
//    float max = _titleArray.count;
//    float min = 0;
//    
//    NSInteger index = 0;
//    
//    if(x< min+0.5){
//        
//        index = min;
//        
//    }else if(x >= max-0.5){
//        
//        index = max;
//        
//    }else{
//        
//        index = (x+0.5)/1;
//    }
//    
//    return index;
//}


//移动ScrollView
-(void)changeScrollOfSet:(NSInteger)index
{
    float  scrollWidth = self.contentSize.width;
    
    // 移到中间(先移到最左边 然后减去偏移)
    // --------*--------
    // --*--
    float leftSpace = self.itemWidth * index - (self.frame.size.width/2.0 - self.itemWidth/2.0);
    
    if(leftSpace<0){
        leftSpace = 0;
    }
    if(leftSpace > scrollWidth - self.frame.size.width){
        leftSpace = scrollWidth - self.frame.size.width;
    }
    [self setContentOffset:CGPointMake(leftSpace, 0) animated:YES];
    
}



#pragma mark - 在ScrollViewDelegate中回调
//-(void)moveToIndex:(float)x
//{
//    [self changeLine:x];
//    NSInteger tempIndex = [self changeProgressToInteger:x];
//    if(tempIndex != _currentIndex){
//        //保证在一个item内滑动，只执行一次
//        [self changeItemColor:tempIndex];
//    }
//    _currentIndex = tempIndex;
//}

//-(void)endMoveToIndex:(float)x
//{
//    [self changeLine:x];
//    [self changeItemColor:x];
//    _currentIndex = x;
//    
//    [self changeScrollOfSet:x];
//}

@end

