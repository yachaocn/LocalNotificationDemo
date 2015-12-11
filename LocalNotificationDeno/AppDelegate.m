//
//  AppDelegate.m
//  LocalNotificationDeno
//
//  Created by NavchinaMacBook on 15/8/4.
//  Copyright (c) 2015年 NavchinaMacBook. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property(nonatomic,strong) NSDateComponents *dateComponets;
@property(nonatomic,strong) UILocalNotification *localNoti;
@property(nonatomic) NSInteger i;
@end

@implementation AppDelegate

-(void)addMinute:(NSTimer *)sender
{
    self.localNoti.fireDate = [self.localNoti.fireDate dateByAddingTimeInterval:100];
    self.localNoti.timeZone = [NSTimeZone defaultTimeZone];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:self.localNoti];
    NSLog(@"%@",self.localNoti.fireDate);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    CGFloat systemVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (systemVersion >= 8.0) {
//        申请用户权限
        UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    }
//    创建本地通知
    UILocalNotification *localNoti = [[UILocalNotification alloc]init];
    self.localNoti = localNoti;
    if (nil != localNoti) {
        NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
        NSDateComponents *dateComponets = [[NSDateComponents alloc]init];
        
        dateComponets.year = 2015;
        dateComponets.month = 12;
        dateComponets.day = 11;
        dateComponets.hour = 12;
        dateComponets.minute = 30;
        self.dateComponets = dateComponets;
        NSDate *date = [calendar dateFromComponents:dateComponets];
        
      NSTimer *timer = [NSTimer timerWithTimeInterval:3*60 target:self selector:@selector(addMinute:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        
        localNoti.fireDate = date;
        localNoti.timeZone = [NSTimeZone defaultTimeZone];
        localNoti.alertTitle = @"提示！";
        localNoti.alertBody = @"该吃饭了！";
        localNoti.alertAction = @"查看！";
        localNoti.soundName = UILocalNotificationDefaultSoundName;
        localNoti.applicationIconBadgeNumber = 1;
        NSDictionary *userinfo = [NSDictionary dictionaryWithObject:@"你好！" forKey:@"nihao"];
        localNoti.userInfo = userinfo;
//        启动本地通知
        [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
        
        //收到通知
        UILocalNotification *not = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
        if (not) {
            NSDictionary *dic = not.userInfo;
            NSString *str = dic[@"nihao"];
            NSLog(@"%@",str);
        }
    }
    return YES;
}
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
        //收到通知
        if (notification) {
            NSDictionary *dic = notification.userInfo;
            NSString *str = dic[@"nihao"];
            NSLog(@"%@",str);
        }

}

@end
