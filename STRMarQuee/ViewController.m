//
//  ViewController.m
//  STRMarQuee
//
//  Created by xingZai on 2017/6/21.
//  Copyright © 2017年 xingZai. All rights reserved.
//

#import "ViewController.h"
#import "STRAutoScrollLabel.h"


@interface ViewController ()

@property (nonatomic, strong) STRAutoScrollLabel *autoLabel;

@property (weak, nonatomic) IBOutlet UIView *scrollContantView;

@property (weak, nonatomic) IBOutlet STRAutoScrollLabel *labelView;

@property (weak, nonatomic) IBOutlet STRAutoScrollLabel *label2View;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    STRAutoScrollLabel *autoLabel = [[STRAutoScrollLabel alloc] initWithFrame:CGRectMake(40, 130, self.view.frame.size.width-80, 40)];
    autoLabel.backgroundColor = [UIColor lightGrayColor];
//    autoLabel.text = @"跑马灯效果";
//    autoLabel.textAlignment = NSTextAlignmentCenter;
//    autoLabel.textAlignment = NSTextAlignmentRight;
//    autoLabel.dirtionType = STRAutoScrollLabelDirtionTypeToRight;
    //color
    autoLabel.textColor = [UIColor redColor];
    autoLabel.text = @"跑马灯效果！哈哈哈哈哈哈，实现了，看看效跑马灯效果！哈哈哈哈哈哈，实现了，看看效果好不好果好不好";
    [self.scrollContantView addSubview:autoLabel];
    self.autoLabel = autoLabel;
    
    //根据实际情况，添加速度及之间间距
    //    autoLabel.speed = 70;
    //    autoLabel.labelBetweenGap = 10;
    
//    self.labelView.text = @"这个是IB创建的跑马灯 与frame方式创建的是一样的效果";
    self.labelView.text = @"aaa";
    
    self.label2View.text = @"bbbbbbbbbbb这个是IB创建的跑马灯 与frame方式创建的是一样的效果";
}

- (IBAction)action:(id)sender {
    NSString *temp = self.label2View.text;
    self.label2View.text = self.labelView.text;
    
    self.labelView.text = self.autoLabel.text;
    
    self.autoLabel.text = temp;
}

@end
