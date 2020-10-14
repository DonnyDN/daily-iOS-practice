//
//  ViewController.m
//  事件传递&响应
//
//  Created by Donny on 2020/10/12.
//

#import "ViewController.h"
#import "BlueView.h"
#import "RedView.h"
#import "YellowView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet YellowView *yellowView;
@property (weak, nonatomic) IBOutlet BlueView *blueView;
@property (weak, nonatomic) IBOutlet RedView *redView;
@property (weak, nonatomic) IBOutlet UIButton *greenButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
//    [self.blueView addGestureRecognizer:tap1];
//
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
//    [self.redView addGestureRecognizer:tap];
    
//    self.blueView.userInteractionEnabled = NO;
//    self.redView.userInteractionEnabled = NO;
    
    
//    [self.greenButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click:(UIGestureRecognizer *)gesture {
    NSLog(@"⭐️点击了 %@",NSStringFromClass(gesture.view.class));
}

- (void)clickButton:(UIButton *)button {
    NSLog(@"⭐️点击了 %@",NSStringFromClass(button.class));
}

#pragma mark - Override

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"ViewController touchBegan");
}


@end

/**
 事件传递（自下而上）：
 Application事件队列->程序主window->subview
 
 每当手指接触屏幕，会生成该事件（UITouch对象）加入到UIApplication管理的事件队列中，在 UIApplication接收到事件之后，就会去调用UIWindow的hitTest:withEvent:和pointInside:withEvent，看看当前点击的点是不是在window内，如果两个函数都满足条件（即hitTest返回非空，pointInside返回YES）时，事件会向子视图传递，继续依次调用其subView的hitTest:withEvent:和pointInside:withEvent:方法，直到子视图没有符合条件的视图，就认为自己是最适合处理该事件的视图。

 事件响应（自上而下）：
 事件响应必须是UIResponder对象及其子类；
 子view -> 父view，控制器view -> 控制器
 
 如果第一响应者是UIButton（UIControl），调用sendAction:to:forEvent:将target、action以及event对象发送给UIApplication，UIApplication对象再通过 sendAction:to:from:forEvent:向target发送action。

 
 */
