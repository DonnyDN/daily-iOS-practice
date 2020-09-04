//
//  Person.m
//  IsEqual_Demo
//
//  Created by Donny on 2020/8/29.
//  Copyright © 2020 Etouch. All rights reserved.
//

#import "Person.h"
#import "YYModel.h"

@implementation Person

+ (Person*)personWithName:(NSString *)name birthday:(NSDate *)birthday {
    Person *p = [[Person alloc] init];
    p.name = name;
    p.birthday = birthday;
    return p;
}

//实现如下方法，是要[dic setObject:@"1" forKey:p1] 作为字典的key
- (id)copyWithZone:(NSZone*)zone {
    return [self yy_modelCopy];
}

#pragma mark - isEqual

//我们可重写系统方法isEqual，自定义判断是否相等
- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[Person class]]) {
        return NO;
    }
    Person *person = object;
    BOOL haveEqualNames = (!self.name && !person.name) || [self.name isEqualToString:person.name];
    BOOL haveEqualBirthdays = (!self.birthday && !person.birthday) || [self.birthday isEqualToDate:person.birthday];
    
    return haveEqualNames && haveEqualBirthdays;
}

//YYModel 也是遍历所有属性，挨个比对
//- (BOOL)isEqual:(id)object {
//    return [self yy_modelIsEqual:object];
//}


#pragma mark - hash

//系统hash方法
//- (NSUInteger)hash {
//    NSUInteger hash = [super hash];
//    NSLog(@"hash = %ld", hash);
//    return hash;
//}

//重写系统hash方法，属性按位异或
- (NSUInteger)hash {
    return [self.name hash] ^ [self.birthday hash];
}

//YYModel 也是遍历所有属性，按位异或
//- (NSUInteger)hash {
//    return [self yy_modelHash];
//}


@end
