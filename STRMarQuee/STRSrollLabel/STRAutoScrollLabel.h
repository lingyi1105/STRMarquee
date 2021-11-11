//
//  STRAutoScrollLabel.h
//  CalfProject
//
//  Created by xingZai on 2017/6/21.
//  Copyright © 2017年 xingZai. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, STRAutoScrollLabelDirtionType) {
 
    STRAutoScrollLabelDirtionTypeToLeft = 0, //to left
    STRAutoScrollLabelDirtionTypeToRight = 1, //to right
    
};


IB_DESIGNABLE
@interface STRAutoScrollLabel : UIView
//set Text
@property (nonatomic, copy) IBInspectable NSString *text;
//set Color
@property (nonatomic, strong) IBInspectable UIColor *textColor;

@property (nonatomic, assign) IBInspectable CGFloat fontSize;

//textAlignment support NSTextAlignmentLeft NSTextAlignmentCenter NSTextAlignmentRight only
@property (nonatomic, assign) IBInspectable NSUInteger textAlignment;

@property (nonatomic, strong) UIFont *font;

//label and label gap
@property (nonatomic, assign) NSInteger labelBetweenGap;
//deafult 2 秒
@property (nonatomic, assign) NSInteger pauseTime;
//deafult STRAutoScrollLabelDirtionTypeToLeft
@property (nonatomic, assign) STRAutoScrollLabelDirtionType dirtionType;
//set speed, default 30
@property (nonatomic, assign) NSInteger speed;

@end


@interface STRAutoScrollView : UIScrollView

//set Text
@property (nonatomic, copy) NSString *text;
//set Color
@property (nonatomic, strong) UIColor *textColor;

//label and label gap
@property (nonatomic, assign) NSInteger labelBetweenGap;
//deafult 2 秒
@property (nonatomic, assign) NSInteger pauseTime;
//deafult STRAutoScrollLabelDirtionTypeToLeft
@property (nonatomic, assign) STRAutoScrollLabelDirtionType dirtionType;
//set speed, default 30
@property (nonatomic, assign) NSInteger speed;

//textAlignment support NSTextAlignmentLeft NSTextAlignmentCenter NSTextAlignmentRight only
@property (nonatomic, assign) NSTextAlignment textAlignment;

@property (nonatomic, assign) CGFloat fontSize;

@property (nonatomic, strong) UIFont *font;

@end
