//
//  CourseManager.h
//  LeciPod
//
//  Created by Sylar on 2018/6/26.
//  Copyright © 2018年 Sylar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseManager : NSObject

+ (instancetype)sharedInstance;
@property(nonatomic,strong)NSString *courseMP4URL;

@end
