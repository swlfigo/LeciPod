//
//  CourseManager.m
//  LeciPod
//
//  Created by Sylar on 2018/6/26.
//  Copyright © 2018年 Sylar. All rights reserved.
//

#import "CourseManager.h"

@implementation CourseManager
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static CourseManager *_instance;
    dispatch_once(&onceToken, ^{
        _instance = [CourseManager new];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _courseMP4URL = @"";
    }
    return self;
}
@end
