//
//  Dog.h
//  Runtime用法种种
//
//  Created by Donny on 2020/6/19.
//  Copyright © 2020 Donny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dog : NSObject

@property (nonatomic,   copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) NSInteger color;

+ (void)allVariableWithClass:(Class)class;

+ (void)allPropertys:(id)model;

+ (void)allMethods:(Class)class;

@end

