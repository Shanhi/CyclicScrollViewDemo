//
//  GCD-Timer.h
//  GCD-Timer
//
//  Created by sShan on 16/6/23.
//  Copyright © 2016年 sShan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCD_Timer : NSObject

@property (nonatomic, assign) NSTimeInterval interval;

@property (nonatomic ,copy) void (^Task)();

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;

@property (nonatomic, readonly, getter=isRepeats) BOOL repeats;

//这创建方式不会影响持有定时器对象的生命周期
+ (instancetype)timerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats target:(id)target selector:(SEL)selector;
//block创建方式会影响持有定时器的对象生命周期，需要使用__weak
+ (instancetype)timerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats task:(void (^)())task;

- (instancetype)resumeTimer;  //定时器不会自动运行，需调用resumeTimer启动
- (void)removeTimer;

@end
