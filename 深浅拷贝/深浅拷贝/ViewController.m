//
//  ViewController.m
//  深浅拷贝
//
//  Created by Donny on 16/1/4.
//  Copyright © 2016年 Donny. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self containerInstanceDeepCopy];
    

//    Person *p1 = [[Person alloc]init];
//    Person *p2 = [p1 copy];
//    Person *p3 = [p1 mutableCopy];
//
//    p2.address = @"kkk";
//    [p3.name appendString:@"AAAAAAAA"];
//
//
//
//    NSLog(@"p1地址:%p",p1);
//    NSLog(@"p2地址:%p",p2);
//    NSLog(@"p3地址:%p",p3);
//
//    NSLog(@"%@,%p",p1.address,p1.address);
//    NSLog(@"%@,%p",p2.address,p2.address);
//    NSLog(@"%@,%p",p3.address,p3.address);
//
//    NSLog(@"%@,%p",p2.name,p2.name);
//    NSLog(@"%@,%p",p3.name,p3.name);
    


}

//对于不可变对象
//copy，       浅拷贝（指针复制）
//mutableCopy，深拷贝（对象复制 指针+内存），返回对象可变（产生新的 可变对象）

- (void)imutableInstanceCopy
{
    NSString *string = @"Hello";
    
    //copy，浅拷贝（拷贝出一个新的指针，指向string指向的内存地址）
    NSString *stringCopy = [string copy];
    //mutableCopy，深拷贝（拷贝出一个新的指针，并且拷贝一份string指向的内存并指向它，不指向string指向的内存地址）
    NSMutableString *stringMutableCopy = [string mutableCopy];
    [stringMutableCopy appendString:@"!"];
    
    NSLog(@"对于不可变对象拷贝：");
    NSLog(@"string:     %@ , %p", string,string);
    NSLog(@"strongCopy: %@ , %p", stringCopy,stringCopy);
    NSLog(@"stringMCopy:%@ , %p", stringMutableCopy,stringMutableCopy);
    
    //结论：//string与stringCopy的内存地址相同,俩不同的指针指向同一个地址；
           //string与stringMutableCopy的内存地址不同，分配了新的内存
}

//对可变对象复制，都是深拷贝，但是copy关键字返回的对象是不可变的的
//copy，       深拷贝（对象复制），返回对象不可变
//mutableCopy，深拷贝（对象复制），返回对象可变

- (void)mutableInstanceCopy
{
    NSMutableString *mutableString = [NSMutableString stringWithString: @"Hello"];
    
    //copy 深拷贝，返回对象不可变
    id mutableStringCopy = [mutableString copy];
    //运行时，此句会报错，错误信息“Attempt to mutate immutable object with appendString:”
//    [mutableStringCopy appendString:@"~~~"];
    
    //mutableCopy 深拷贝，返回对象可变
    NSMutableString *mutableStringMutableCopy = [mutableString mutableCopy];
    [mutableStringMutableCopy appendString:@"!"];
    
    //内存地址都不同
    NSLog(@"mutableString:    %@ , %p", mutableString,mutableString);
    NSLog(@"mutableStringCopy:%@ , %p", mutableStringCopy,mutableStringCopy);
    NSLog(@"mutableStringMutableCopy:%@ , %p", mutableStringMutableCopy,mutableStringMutableCopy);
}


//容器对象（NSArray）遵循非容器对象的拷贝原则
//
//注意容器里套可变对象的情况（容器内的元素都是浅拷贝）
//开发时注意，数组中都是模型时，拷贝后的数组中的模型还是原来数组的模型，一个变都改变
- (void)containerInstanceShallowCopy
{
    NSArray *array = [NSArray arrayWithObjects:[NSMutableString stringWithString:@"Welcome"],@"to",@"Xcode",nil];
    
    //浅拷贝->没创建新的容器，容器内的元素是指针赋值（浅拷贝）
    NSArray *arrayCopy = [array copy];
    //深拷贝->创建了新的容器，容器内的元素是指针赋值（浅拷贝）
    NSMutableArray *arrayMutableCopy = [array mutableCopy];
    
    NSLog(@"array:     %p", array);
    NSLog(@"arrayCopy: %p", arrayCopy);
    NSLog(@"arrayMutableCopy: %p", arrayMutableCopy);
    
    //容器内的对象是浅拷贝，即它们在内存中只有一份
    NSMutableString *testString = [array objectAtIndex:0];
    [testString appendString:@" you"];
    //三个数组的内容同时改变
    NSLog(@"array[0]: %@", array[0]);
    NSLog(@"arrayCopy[0]: %@", arrayCopy[0]);
    NSLog(@"arrayMutableCopy[0]: %@", arrayMutableCopy[0]);
}

//对象序列化
//实现真正意义上的深复制（数组内对象也要求是对象复制）

- (void)containerInstanceDeepCopy
{
    NSArray *array = [NSArray arrayWithObjects:[NSMutableString stringWithString:@"Welcome"],@"to",@"Xcode",nil];
    
    //数组内对象是指针复制
    NSArray *deepCopyArray = [[NSArray alloc] initWithArray:array];
    //真正意义上的深复制，数组内对象是对象复制
    NSArray *trueDeepCopyArray = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:array]];
    
    NSLog(@"array: %p", array);
    NSLog(@"deepCopyArray: %p", deepCopyArray);
    NSLog(@"trueDeepCopyArray: %p", trueDeepCopyArray);
    
    //改变array的第一个元素
    [[array objectAtIndex:0] appendString:@" you"];
    
    //只影响deepCopyArray数组的第一个元素
    NSLog(@"array[0]: %@", array[0]);
    NSLog(@"arrayCopy[0]: %@", deepCopyArray[0]);
    //不影响trueDeepCopyArray数组的第一个元素，是真正意义上的深拷贝
    NSLog(@"arrayMutableCopy[0]: %@", trueDeepCopyArray[0]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
