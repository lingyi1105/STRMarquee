# STRMarquee
## 跑马灯，向左或向右滚动label



2021-11-11 edited by larry

增加功能：

1. 非滚动文字对齐属性
2. 文字大小属性
3. font属性
4. 嵌套自定义UIView，更换的支持 Interface Builder 方式使用

修复：

1. 修复 Label 可以滑动问题，关闭scrollEnabled，以使触摸滑动失效
2. 修复前后台切换，动画停止问题
3. 修复 scrollView 的 framesize 自动适配问题
4. 修复动态变换内容 Label frame 适配问题




```
STRAutoScrollLabel *autoLabel = [[STRAutoScrollLabel alloc] initWithFrame:CGRectMake(40, 130, self.view.frame.size.width-80, 40)];
autoLabel.backgroundColor = [UIColor lightGrayColor];
autoLabel.textAlignment = NSTextAlignmentRight;
autoLabel.dirtionType = STRAutoScrollLabelDirtionTypeToRight;
//color
autoLabel.textColor = [UIColor redColor];
autoLabel.text = @"跑马灯效果！哈哈哈哈哈哈，实现了，看看效跑马灯效果！哈哈哈哈哈哈，实现了，看看效果好不好果好不好";
//autoLabel.text = @"跑马灯效果";
[self.scrollContantView addSubview:autoLabel];
```





![image](https://github.com/TheYouth/STRMarquee/blob/master/screenShots/%E8%B7%91%E9%A9%AC%E7%81%AF%E6%95%88%E6%9E%9C%E5%9B%BE.gif)

