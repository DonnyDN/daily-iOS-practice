//
//  ViewController.m
//  NSInvocation使用
//
//  Created by 杜宁 on 2017/2/23.
//  Copyright © 2017年 Donny. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 方法签名中保存了方法的名称/参数/返回值，协同NSInvocation来进行消息的转发
    // 方法签名一般是用来设置参数和获取返回值的, 和方法的调用没有太大的关系
    SEL aSelector = @selector(run:);
    //方法信号
    //1、创建一个函数签名，这个签名可以是任意的,但需要注意，签名函数的参数数量要和调用的一致。
    //目标函数无参的话，这样随意也可以：
//    NSMethodSignature  *signature = [NSNumber instanceMethodSignatureForSelector:@selector(init)];
//    注意：签名函数的参数数量要和调用函数的一致。测试后发现，当签名函数参数数量多可以,少不行.
    NSMethodSignature  *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    
    
    //此时我们应该判断方法是否存在，如果不存在这抛出异常
    if (signature == nil) {
        //aSelector为传进来的方法
        NSString *info = [NSString stringWithFormat:@"%@方法找不到", NSStringFromSelector(aSelector)];
        [NSException raise:@"方法调用出现异常" format:info, nil];
    }
    
    //signature.numberOfArguments获取的参数个数,是包含self和_cmd的，然后比较方法需要的参数和外界传进来的参数个数，所以-2；
    NSLog(@"argu:%lu",(unsigned long)signature.numberOfArguments);
    
    
    // NSInvocation中保存了方法所属的对象/方法名称/参数/返回值
    //其实NSInvocation就是将一个方法变成一个对象
    //2、创建NSInvocation对象，只能使用其类方法来初始化，不可使用alloc/init方法。
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    //设置方法调用者
    invocation.target = self;
    //注意：这里的方法名一定要与方法签名类中的方法一致
    invocation.selector = aSelector;
    
    ViewController *vc = self;
    NSString *way = @"byCar";
//    注意：这里的操作传递的都是地址。如果是OC对象，也是取地址。
    //设置参数，这里的Index要从2开始，以为0跟1已经默认被占据了，分别是target,selector.
//    [invocation setArgument:&vc atIndex:0];
//    [invocation setArgument:&aSelector atIndex:1];
    [invocation setArgument:&way atIndex:2];

    //3、调用invoke方法
    [invocation invoke];
    
    
    [self getResultWithSignature:signature :invocation];

}


//判断当前调用的方法是否有返回值
- (id)getResultWithSignature:(NSMethodSignature *)signature :(NSInvocation *)invocation{
    
    /**
     目标函数的返回值需要事先知道类型，不知道的话，用signature.methodReturnType检测一下,获得返回的类型编码，因此可以推断返回值的具体类型
     //    const char *returnType = signature.methodReturnType;
     //    NSLog(@"returnType:%@",[NSString stringWithUTF8String:returnType]);
     
     注意：我们可以自己手动设置返回值
     //    int c = 1;
     //    [invocation setReturnValue: &c];
     //    int d = 2;
     //    [invocation getReturnValue:&d];
     
     1、返回类型是基本类型，就定义基本类型的变量，如下：
     int d = 0;
     //取这个返回值
     [invocation getReturnValue:&d];
     
     2、返回类型是对象，arc情况下容易出现崩溃问题，如下两种解决方案。arc下result如果用strong的，默认NSInvocation认为已经对返回对象retain一次，实际上并没有，当返回对象出了作用域时候，已经被收回。导致崩溃。
     
     解决方案1
     
     void *result = nil;
     
     [invocation getReturnValue:&result];
     
     NSLog(@"vc:%@",(__bridge ViewController*)result);
     
     
     
     解决方案1
     
     UIViewController * __unsafe_unretained result = nil;
     
     [invocation getReturnValue:&result];
     
     NSLog(@"result:%@",result);
     
     }
     */
    
    __weak id result = nil;
    if (signature.methodReturnLength != 0) {//有返回值
        
        [invocation getReturnValue:&result];
        
        NSLog(@"result:%@",result);
    }
    return result;
}

//实现run:方法
- (NSString *)run:(NSString *)method{
    NSLog(@"%@",method);
    return [NSString stringWithFormat:@"返回值11%@",method];
//    return 333;
}

//实现run:方法
- (void)run1{
    NSLog(@"run1无参");
}

@end
