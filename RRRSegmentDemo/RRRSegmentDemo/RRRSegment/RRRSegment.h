//
//  RXSegmentedControl.h
//  ZHStore
//
//  Created by 张瑞想 on 16/2/24.
//  Copyright © 2016年 zhanghetianxia. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^RRRItemsControlViewTapBlock)(NSInteger index,BOOL animation);

@interface RRRSegment : UIScrollView


#pragma mark -  外观
// item宽度
@property(nonatomic,assign)float itemWidth;                                     //default is 60
// 字体
@property(nonatomic,strong)UIFont *itemFont;                                    //default is boldSystemFontOfSize:16
// 字体颜色
@property(nonatomic,strong)UIColor *textColor;                                  //default is blackColor
// 选中字体颜色
@property(nonatomic,strong)UIColor *selectedTextColor;                          //default is redColor
// 选中字体大小
@property(nonatomic,strong)UIFont *selectedItemFont;                            //default is 16
// 选中背景颜色
@property(nonatomic,strong)UIColor *selectedBgColor;                            //default is whiteColor
// 横线的占比
@property(nonatomic,assign)float linePercent;                                   //default is 1.0
// 横线高度
@property(nonatomic,assign)float lineHieght;                                    //default is 2.0
// 横线颜色
@property(nonatomic,strong)UIColor *lineColor;                                  //default is redColor
// 分割线颜色
@property(nonatomic,strong)UIColor *separatorColor;                             //default is whiteColor
// 动画
@property(nonatomic,assign)BOOL tapAnimation;                                   //default is YES;
// 是否允许自动滑动
@property(nonatomic,assign)BOOL isCanAutomaticallySlide;                        //default is YES;
// 是否显示下划线
@property(nonatomic,assign)BOOL isShowUnderline;                                //default is NO;
// 是否显示分割线
@property(nonatomic,assign)BOOL isShowSeparatorline;                            //default is NO;
// 是否显示边框
@property(nonatomic,assign)BOOL isShowBorderline;                               //default is NO;


#pragma mark - 数据
// 标题数组
@property(nonatomic,strong)NSArray *titleArray;
// 当前index
@property(nonatomic,readonly)NSInteger currentIndex;
// 回调block
@property(nonatomic,copy)RRRItemsControlViewTapBlock tapItemWithIndex;


#pragma mark - 事件

//-(void)moveToIndex:(float)index;                                                //called in scrollViewDidScroll
/*
 首次出现，需要高亮显示第二个元素,scroll: 是外部关联的scroll
 [self endMoveToIndex:2];
 [scroll scrollRectToVisible:CGRectMake(2*w, 0.0, w,h) animated:NO];
 */
//-(void)endMoveToIndex:(float)index;                                             //called in scrollViewDidEndDecelerating

@end

