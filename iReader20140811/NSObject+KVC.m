//
//  NSObject+KVC.m
//  BookStoreDemo
//
//  Created by lcl on 9/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "NSObject+KVC.h"

@implementation NSObject (KVC)
- (id)valueForUndefinedKey:(NSString *)key{
    return objc_getAssociatedObject(self, (__bridge const void *)(key));
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    objc_setAssociatedObject(self, (__bridge const void *)(key), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
