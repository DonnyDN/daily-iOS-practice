//
//  Person.h
//  IsEqual_Demo
//
//  Created by Donny on 2020/8/29.
//  Copyright © 2020 Etouch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCopying,NSMutableCopying>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSDate *birthday;

+ (Person*)personWithName:(NSString *)name birthday:(NSDate *)birthday;

@end
