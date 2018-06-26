//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  LeciPod.m
//  LeciPod
//
//  Created by Sylar on 2018/6/26.
//  Copyright (c) 2018年 Sylar. All rights reserved.
//

#import "LeciPod.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import "CourseManager.h"


CHDeclareClass(LCVocabularyInfoResponseObject)
CHOptimizedMethod1(self, id, LCVocabularyInfoResponseObject, initWithDictionary, id, arg1){
    id instance = CHSuper1(LCVocabularyInfoResponseObject, initWithDictionary, arg1);
    return instance;
}
//FreeState返回1则为免费
CHOptimizedMethod0(self, long long, LCVocabularyInfoResponseObject, freeState){
    return 1;
}

//课程Controller全部能看
CHDeclareClass(LXVideoViewController);
CHOptimizedMethod0(self, BOOL, LXVideoViewController, isVideoCoursePay){
    return YES;
}
//乐学
CHDeclareClass(LCMyActivityDetailController);
@interface LCMyActivityDetailController
@property(nonatomic,assign)BOOL isVideoCoursePay;
@end
CHOptimizedMethod0(self, BOOL, LCMyActivityDetailController, isVideoCoursePay){
    BOOL _isVideoCoursePay = CHIvar_(self, "isVideoCoursePay");
    return YES;
}

//乐学Model
CHDeclareClass(LCLXActivityDetailModel);
CHOptimizedMethod1(self, id, LCLXActivityDetailModel, initWithActivityDictionary, id, arg1){
    id instance = CHSuper1(LCLXActivityDetailModel, initWithActivityDictionary, arg1);
    return instance;
}

CHDeclareClass(LCMoviePlayerViewController);
CHOptimizedMethod2(self, void, LCMoviePlayerViewController, setURL, id, arg1, SeekToTime, double, arg2){
    NSURL *argURL = arg1;
    NSString *argString = argURL.absoluteString;
    if ([argString isEqualToString:@""]) {
        argString = [CourseManager sharedInstance].courseMP4URL;
        argURL = [NSURL URLWithString:argString];
    }
    CHSuper2(LCMoviePlayerViewController, setURL, argURL, SeekToTime, arg2);
}

//获得全局变量播放视频
CHDeclareClass(MCDownloader);
CHOptimizedMethod1(self, id, MCDownloader, downloadReceiptForURLString, id, arg1){
    NSLog(@"");
    NSString *arg1String = arg1;
    if (![arg1 isEqualToString:@""]) {
        [CourseManager sharedInstance].courseMP4URL = arg1String;
    }else{
        NSLog(@"收费视频");
    }
    
    id instance = CHSuper1(MCDownloader, downloadReceiptForURLString, arg1);
    return instance;
}


CHDeclareClass(VideoListCell)
CHDeclareClass(LXRelevantCourseVideoObject);
@interface VideoListCell
@property(nonatomic,assign)BOOL isPay;
@property(nonatomic,assign)BOOL isExpire;
@end
@interface LXRelevantCourseVideoObject
@property(nonatomic,assign)NSString *courseType;
@end
CHOptimizedMethod0(self, BOOL, VideoListCell, isPay){
    
    BOOL _isPay = CHIvar_(self, "isPay");
    
    return YES;
}

CHOptimizedMethod0(self, BOOL, VideoListCell, isExpire){
    BOOL _isExpire = CHIvar_(self, "isExpire");
    return NO;
}
CHOptimizedMethod1(self, void, VideoListCell, setVideoObj, id, arg1){
    NSLog(@"");
    [arg1 setValue:@"4" forKey:@"courseType"];
    CHSuper1(VideoListCell, setVideoObj, arg1);
}



CHConstructor{
    CHLoadLateClass(MCDownloader);
    CHHook1(MCDownloader, downloadReceiptForURLString);
    
    CHLoadLateClass(LCVocabularyInfoResponseObject);
    CHHook1(LCVocabularyInfoResponseObject, initWithDictionary);
    CHHook0(LCVocabularyInfoResponseObject, freeState);
    
    
    CHLoadLateClass(LXVideoViewController);
    CHHook0(LXVideoViewController, isVideoCoursePay);
    CHLoadLateClass(LCMyActivityDetailController);
    CHHook0(LCMyActivityDetailController, isVideoCoursePay);
    
    
    CHLoadLateClass(LCMoviePlayerViewController);
    CHHook2(LCMoviePlayerViewController, setURL, SeekToTime);
    
    CHLoadLateClass(VideoListCell);
    CHHook0(VideoListCell, isPay);
    CHHook0(VideoListCell, isExpire);
    CHHook1(VideoListCell, setVideoObj);
    
    CHLoadLateClass(LCLXActivityDetailModel);
    CHHook1(LCLXActivityDetailModel, initWithActivityDictionary);
}
