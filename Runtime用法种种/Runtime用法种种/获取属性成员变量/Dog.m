//
//  Dog.m
//  Runtime用法种种
//
//  Created by Donny on 2020/6/19.
//  Copyright © 2020 Donny. All rights reserved.
//

#import "Dog.h"
#import <objc/runtime.h>

@interface Dog ()
{
    NSString *_nickName;
}
@property (nonatomic, assign) NSInteger food;
@end

@implementation Dog

//获取对象的全部变量（属性+成员变量）
+ (void)allVariableWithClass:(Class)class {
    
    NSMutableArray *array = [NSMutableArray array];
    unsigned int count = 0;
    Ivar *members = class_copyIvarList(class, &count);
    for (int i = 0 ; i < count; i++) {
        Ivar var = members[i];
        const char *memberName = ivar_getName(var);
        const char *memberType = ivar_getTypeEncoding(var);
        
        [array addObject: [NSString stringWithFormat:@"%s - %s",memberName, memberType]];
        
        //object_setIvar(object, var, @"lufei”); 修改变量值
        NSLog(@"%s----%s", memberName, memberType);

    }
    NSLog(@"所有属性和成员变量：\n%@",array);
}

//获取全部属性
+ (void)allPropertys:(id)model {
    
    NSMutableArray *array = [NSMutableArray array];
    uint count;
    objc_property_t *properties = class_copyPropertyList([model class], &count);
    for (int i = 0; i<count; i++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        
        id value = [model valueForKey:name] ?: @"nil";
        [array addObject:[NSString stringWithFormat:@"%@ - %@", name, value]];
    }
    free(properties);
    NSLog(@"%@", [NSString stringWithFormat:@"%@所有属性:%@",model,array]);
}

//获取全部方法
+ (void)allMethods:(Class)class {
    
    NSMutableArray *array = [NSMutableArray array];
    unsigned int count ;
    Method *methods = class_copyMethodList(class, &count);
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        NSString *methodName  = NSStringFromSelector(method_getName(method));
        [array addObject:methodName ?: @""];
    }
    free(methods);
    NSLog(@"%@类的所有方法：%@",class,array);
}


@end
