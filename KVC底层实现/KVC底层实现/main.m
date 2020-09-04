//
//  main.m
//  KVC底层实现
//
//  Created by Donny on 2020/8/24.
//  Copyright © 2020 Etouch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Person *person = [Person new];
        [person setValue:@"123" forKey:@"name"];
        
        NSLog(@"取值valueForKey:%@", [person valueForKey:@"name"]);
        
    }
    return 0;
}
