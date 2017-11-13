//
//  GetAppLists.m
//  ULife
//
//  Created by ashen on 16/12/29.
//  Copyright © 2016年 Uubee. All rights reserved.
//

#import "GetAppLists.h"
#include <objc/runtime.h>
@implementation GetAppLists
    
- (NSArray * )getAppLists{
    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    NSArray * appList = [workspace performSelector:@selector(allApplications)];
    Class LSApplicationProxy_class = object_getClass(@"LSApplicationProxy");
    for (LSApplicationProxy_class in appList)
    {
        //这里可以查看一些信息
        NSString *bundleID = [LSApplicationProxy_class performSelector:@selector(applicationIdentifier)];
        NSString *version =  [LSApplicationProxy_class performSelector:@selector(bundleVersion)];
        NSString *shortVersionString =  [LSApplicationProxy_class performSelector:@selector(shortVersionString)];
        NSLog(@"bundleID：%@\n version： %@\n ,shortVersionString:%@\n", bundleID,version,shortVersionString);
    }
    return appList;
}
@end
