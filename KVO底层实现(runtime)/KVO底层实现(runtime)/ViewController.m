//
//  ViewController.m
//  KVO底层实现(runtime)
//
//  Created by 杜宁 on 2017/2/22.
//  Copyright © 2017年 Donny. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()
@property (nonatomic, strong) Person *person1;
@property (nonatomic, strong) Person *person2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _person1 = [[Person alloc]init];
    _person2 = [[Person alloc]init];
    
    NSLog(@"添加KVO监听之前，setter方法实现地址：\n  p1 = %p, p2 = %p",
          [_person1 methodForSelector: @selector(setAge:)],
          [_person2 methodForSelector: @selector(setAge:)]);
    
    [_person1 addObserver:self
               forKeyPath:@"age"
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:nil];
    
    NSLog(@"添加KVO监听之后，setter方法实现地址：\n  p1 = %p, p2 = %p",
          [_person1 methodForSelector: @selector(setAge:)],
          [_person2 methodForSelector: @selector(setAge:)]);
    
    //发现_person1的setter方法实现地址变了
    
    //    [_person1 removeObserver:self forKeyPath:@"age"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    NSLog(@"监听到%@的%@属性变化为%@",object,keyPath,change);
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //自动触发KVO
//    _person1.age = 100;
    
    //手动触发KVO - 步骤2
    //给age赋值不会触发KVO回调了，如下可以触发
    [_person1 willChangeValueForKey:@"age"];
    //此处可以给age赋值
    [_person1 didChangeValueForKey:@"age"];
}


@end
