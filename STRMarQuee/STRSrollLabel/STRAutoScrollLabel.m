//
//  STRAutoScrollLabel.m
//  CalfProject
//
//  Created by renxingxing on 2017/6/21.
//  Copyright © 2017年 renxingxing. All rights reserved.
//

#import "STRAutoScrollLabel.h"
#import <QuartzCore/QuartzCore.h>

const NSInteger NumLabels = 2;
const NSInteger AutoLabel_speed = 30;
const NSInteger AutoLabel_pause = 2;
const NSInteger AutoLabel_betweenGap = 10;


@interface STRAutoScrollLabel()

@property (nonatomic, strong) STRAutoScrollView *scrollView;


#if TARGET_INTERFACE_BUILDER
@property (nonatomic, strong) UILabel *label;
#endif
@end

@implementation STRAutoScrollLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    _scrollView = [[STRAutoScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_scrollView];
    
//    NSLayoutConstraint *widthLC = [NSLayoutConstraint constraintWithItem:_scrollView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.frame.size.width];
//    NSLayoutConstraint *heightLC = [NSLayoutConstraint constraintWithItem:_scrollView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.frame.size.height];
//    NSLayoutConstraint *centerXLC = [NSLayoutConstraint constraintWithItem:_scrollView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_scrollView.superview attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
//    NSLayoutConstraint *centerYLC = [NSLayoutConstraint constraintWithItem:_scrollView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_scrollView.superview attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
//    [_scrollView addConstraints:@[widthLC, heightLC]];
//    [_scrollView.superview addConstraint:centerXLC];
//    [_scrollView.superview addConstraint:centerYLC];
}

- (void)setText:(NSString *)text {
    _text = text;
    _scrollView.text = text;
#if TARGET_INTERFACE_BUILDER
    _label = [[UILabel alloc] initWithFrame:self.bounds];
    _label.text = text;
    [self addSubview:_label];
#endif
}

- (void)setDirtionType:(STRAutoScrollLabelDirtionType)dirtionType {
    _dirtionType = dirtionType;
    _scrollView.dirtionType = dirtionType;
}

- (void)setLabelBetweenGap:(NSInteger)labelBetweenGap {
    _labelBetweenGap = labelBetweenGap;
    _scrollView.labelBetweenGap = labelBetweenGap;
}

- (void)setPauseTime:(NSInteger)pauseTime {
    _pauseTime = pauseTime;
    _scrollView.pauseTime = pauseTime;
}

- (void)setSpeed:(NSInteger)speed {
    _speed = speed;
    _scrollView.speed = speed;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _scrollView.textColor = textColor;
#if TARGET_INTERFACE_BUILDER
    _label.textColor = textColor;
#endif
}

- (void)setTextAlignment:(NSUInteger)textAlignment {
    _textAlignment = textAlignment;
    _scrollView.textAlignment = textAlignment;
#if TARGET_INTERFACE_BUILDER
    _label.textAlignment = textAlignment;
#endif
}

- (void)setFont:(UIFont *)font {
    _font = font;
    _scrollView.font = font;
}

- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
    _scrollView.fontSize = fontSize;
}

@end



@interface STRAutoScrollView() {
    
    UILabel *_label[NumLabels];
    NSInteger _speed;
    
}

@end

@implementation STRAutoScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self rejustLabels];
}

- (void)loadUI {
    for (NSInteger i = 0; i < NumLabels; i++) {
        _label[i] = [[UILabel alloc] init];
        [_label[i] setTextColor:[UIColor grayColor]];
        [_label[i] setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_label[i]];
    }
    
//    [_label[0] setBackgroundColor:[UIColor blueColor]];
//    [_label[1] setBackgroundColor:[UIColor yellowColor]];
    
    _pauseTime = AutoLabel_pause;
    _labelBetweenGap = AutoLabel_betweenGap;
    _speed = AutoLabel_speed;
    _dirtionType = STRAutoScrollLabelDirtionTypeToLeft;
    
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.scrollEnabled = NO;
}

- (void)rejustLabels {
    self.frame = self.superview.bounds;
    
    //set labels frame 及self contentsize和is scroll
    CGFloat offset = 0.0f;
    for (NSInteger i = 0; i < NumLabels; i++) {
        [_label[i] sizeToFit];
        CGPoint center = _label[i].center;
        center.y = self.center.y - self.frame.origin.y;
        _label[i].center = center;
        
        CGRect frame = _label[i].frame;
        frame.origin.x = offset;
        _label[i].frame = frame;
        
        offset += _label[i].frame.size.width + _labelBetweenGap;
    }
    CGSize size;
    size.width = _label[0].frame.size.width + self.frame.size.width + _labelBetweenGap;
    size.height = self.frame.size.height;
    self.contentSize = size;
    
    if (_label[0].frame.size.width > self.frame.size.width) {
        //show label
        for (NSInteger i = 1; i <NumLabels; i++) {
            _label[i].hidden = NO;
        }
        [self scroll];
    } else {
        for (NSInteger i = 1; i < NumLabels; i++) {
            _label[i].hidden = YES;
        }
        if (self.textAlignment == NSTextAlignmentLeft) {
            CGRect frame = _label[0].frame;
            frame.origin.x = 0;
            _label[0].frame = frame;
        } else if (self.textAlignment == NSTextAlignmentRight) {
            CGRect frame = _label[0].frame;
            frame.origin.x = self.frame.size.width - frame.size.width;
            _label[0].frame = frame;
        } else {
            CGPoint center = _label[0].center;
            center.x = self.center.x - self.frame.origin.x;
            _label[0].center = center;
        }
        [self scrollRemove];
    }
}

- (void)scroll {
    [self scrollRemove];
    
    [UIView beginAnimations:@"scroll" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:_label[0].frame.size.width/_speed];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    //animations
    if (_dirtionType == STRAutoScrollLabelDirtionTypeToLeft) {
        self.contentOffset = CGPointMake(_label[0].frame.size.width+_labelBetweenGap, 0);
    } else if (_dirtionType == STRAutoScrollLabelDirtionTypeToRight) {
        self.contentOffset = CGPointMake(0, 0);
    }
    [UIView commitAnimations];
}

- (void)scrollRemove {
    //delete before animations
    [self.layer removeAllAnimations];
    
    if (_dirtionType == STRAutoScrollLabelDirtionTypeToLeft) {
        self.contentOffset = CGPointMake(0, 0);
    } else if (_dirtionType == STRAutoScrollLabelDirtionTypeToRight) {
        self.contentOffset = CGPointMake(_label[0].frame.size.width+_labelBetweenGap, 0);
    }
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finish context:(NSString *)context {
    if (finish.integerValue == 1 && _label[0].frame.size.width > self.frame.size.width) {
        //pause time
        [NSTimer scheduledTimerWithTimeInterval:_pauseTime target:self selector:@selector(scroll) userInfo:nil repeats:NO];
    }
}

- (void)setText:(NSString *)text {
    if ([text isEqualToString:_label[0].text]) {
        if (_label[0].frame.size.width > self.frame.size.width) {
            [self scroll];
        }
        return;
    }
    for (NSInteger i = 0; i< NumLabels; i++) {
        _label[i].text = text;
    }
    [self rejustLabels];
}

- (void)setDirtionType:(STRAutoScrollLabelDirtionType)dirtionType {
    _dirtionType = dirtionType;
    [self rejustLabels];
}

- (void)setLabelBetweenGap:(NSInteger)labelBetweenGap {
    _labelBetweenGap = labelBetweenGap;
    [self rejustLabels];
}

- (void)setPauseTime:(NSInteger)pauseTime {
    _pauseTime = pauseTime;
    [self rejustLabels];
}

- (void)setSpeed:(NSInteger)speed {
    _speed = speed;
    [self rejustLabels];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    for (NSInteger i = 0; i <NumLabels; i++) {
        _label[i].textColor = textColor;
    }
    [self rejustLabels];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    [self rejustLabels];
}

- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
    for (NSInteger i = 0; i <NumLabels; i++) {
        _label[i].font = [UIFont systemFontOfSize:fontSize];
    }
    [self rejustLabels];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    for (NSInteger i = 0; i <NumLabels; i++) {
        _label[i].font = font;
    }
    [self rejustLabels];
}

@end
