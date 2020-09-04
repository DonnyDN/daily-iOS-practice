//
//  ViewController.m
//  离屏渲染
//
//  Created by Donny on 2020/7/7.
//  Copyright © 2020 Etouch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test1];
    [self test2];
    
    [self buttonTip];

}

- (void)test1 {
    //clipsToBounds 与 layer.masksToBounds 一样
    //view的背景色就是layer的背景色（clearColor 不会设置content颜色）
//    NSLog(@"背景色:%d",CGColorEqualToColor(view2.backgroundColor.CGColor, view2.layer.backgroundColor));

    
    //无 圆角+裁剪+内容（单层内容）
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(30, 60, 100, 100)];
    view1.layer.cornerRadius = 50;
    view1.clipsToBounds = YES;
    view1.layer.contents = (__bridge id)[UIImage imageNamed:@"icon"].CGImage;
    [self.view addSubview:view1];
    
    //无 圆角+裁剪+内容（单层内容）
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(30, 210, 100, 100)];
    view2.layer.cornerRadius = 50;
    view2.clipsToBounds = YES;
    view2.backgroundColor = UIColor.redColor;
    [self.view addSubview:view2];
    
    
    //有 圆角+裁剪+layerBorder+layerContent（多层内容）
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(30, 350, 100, 100)];
    view3.layer.cornerRadius = 50;
    view3.clipsToBounds = YES;
    view3.layer.borderWidth = 10;
    view3.layer.borderColor = UIColor.blackColor.CGColor;
    view3.layer.contents = (__bridge id)[UIImage imageNamed:@"icon"].CGImage;
    [self.view addSubview:view3];
    
    //有 圆角+裁剪+背景色+subview背景色（多层内容）
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(30, 510, 100, 100)];
    view4.layer.cornerRadius = 50;
    view4.clipsToBounds = YES;
    view4.backgroundColor = UIColor.redColor;
    [self.view addSubview:view4];
    UIView *subView4 = [[UIView alloc] initWithFrame:CGRectMake(30, 30, 50, 50)];
    subView4.backgroundColor = [UIColor blueColor];
    [view4 addSubview:subView4];
    
    //有 圆角+裁剪+背景色+subview layerContent（多层内容）
    UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(30, 640, 100, 100)];
    view5.layer.cornerRadius = 50;
    view5.clipsToBounds = YES;
    view5.backgroundColor = UIColor.redColor;
    [self.view addSubview:view5];
    UIView *subView5 = [[UIView alloc] initWithFrame:CGRectMake(30, 30, 50, 50)];
    subView5.layer.contents = (__bridge id)([UIImage imageNamed:@"icon"].CGImage);
    [view5 addSubview:subView5];

    
    /** 总结：
     
     触发离屏渲染：圆角+裁剪+多层content绘制
     
     设置圆角cornerRadius，并开启layer.masksToBounds或clipsToBounds时，同时有多层content时，会触发离屏渲染；
     当有子view时，子view也有content，就容易导致离屏渲染；
     content指颜色、图片或边框等图像信息（包括在view或layer的draw方法中进行绘制等）
     
     原因：
     当我们设置了圆角+裁剪时，裁剪属性会应用到所有的图层上。
     本来从后往前绘制（画家算法），绘制完一个图层就可以丢弃了。但现在需要依次在 Offscreen Buffer 中保存，等待圆角+裁剪处理，这就是 离屏渲染。

     */
}

- (void)test2 {
    // 无 cornerRadius + masksToBounds + content
    UIImageView *img1 = [UIImageView.alloc initWithFrame:CGRectMake(250, 60, 100, 100)];
    img1.image = [UIImage imageNamed:@"icon"];
    img1.layer.cornerRadius = 50;
    img1.layer.masksToBounds = YES;
    [self.view addSubview:img1];
    
    // 无 cornerRadius + backgroundColor
    UIImageView *img2 = [UIImageView.alloc initWithFrame:CGRectMake(250, 210, 100, 100)];
    img2.layer.cornerRadius = 50;
    img2.backgroundColor = UIColor.redColor;
    [self.view addSubview:img2];
    
    // 无 cornerRadius + content + backgroundColor
    UIImageView *img3 = [UIImageView.alloc initWithFrame:CGRectMake(250, 350, 100, 100)];
    img3.image = [UIImage imageNamed:@"icon"];
    img3.backgroundColor = UIColor.redColor;
    img3.layer.cornerRadius = 50;
    [self.view addSubview:img3];
    
    // 有（多层内容） cornerRadius + masksToBounds + content + backgroundColor
    UIImageView *img4 = [UIImageView.alloc initWithFrame:CGRectMake(250, 510, 100, 100)];
    img4.image = [UIImage imageNamed:@"icon"];
    img4.backgroundColor = UIColor.redColor;
    img4.layer.cornerRadius = 50;
    img4.layer.masksToBounds = YES;
    [self.view addSubview:img4];
}


/**
 创建 UIButton 时，设置 image，就会给 imageView 设置图片内容，再给 UIButton 设置圆角+裁剪，就会离屏渲染；
 可以直接给 UIButton 的 imageView 设置 圆角+裁剪
 */
- (void)buttonTip {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(170, 660, 80, 80)];
//    button.layer.cornerRadius = 20;
//    button.clipsToBounds = YES;
    
    //直接设置 imageView 圆角+裁剪
    button.imageView.layer.cornerRadius = 20;
    button.imageView.clipsToBounds = YES;
    
    [button setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
    [self.view addSubview:button];
}

@end
