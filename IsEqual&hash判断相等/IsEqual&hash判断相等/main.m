//
//  main.m
//  IsEqual_Demo
//
//  Created by Donny on 2020/8/29.
//  Copyright © 2020 Etouch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //如下，对象强转Int，相当于系统hash方法
        Person *person = [[Person alloc] init];
        NSLog(@"person = %p", person);
        NSLog(@"person = %ld", (NSInteger)person);
        NSLog(@"[person1 hash] = %ld", [person hash]);

        
        //如下，[p1 isEqual:p2] = YES，但是却都添加到Set集合中了，isEqual没问题，是p1和p2的hash有问题
        //系统判定p1和p2的hash是不一样的，所以我们重写系统hash方法，使之hash也相等
        NSString *name = @"x";
        NSDate *date = [NSDate date];
        Person *p1 = [Person personWithName:name birthday:date];
        Person *p2 = [Person personWithName:name birthday:date];
        NSLog(@"[p1 isEqual:p2] = %@", [p1 isEqual:p2] ? @"YES" : @"NO");

        NSMutableSet *set = [NSMutableSet set];
        [set addObject:p1];
        [set addObject:p2];
        NSLog(@"set count = %ld", set.count);
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"1" forKey:p1];
        [dic setObject:@"2" forKey:p2];
        NSLog(@"dic count = %ld", dic.allKeys.count);

    }
    return 0;
}
