//
//  CyclicScrollView.h
//  CyclicScrollView
//
//  Created by sShan on 16/12/26.
//  Copyright © 2016年 sShan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CyclicScrollView : UIView

@property (nonatomic, strong) NSArray *imagesArray;
//时间间隔默认2秒
@property (nonatomic, assign) NSTimeInterval interval;

- (instancetype)initWithImagesArray:(NSArray <UIImage *>*)imagesArray;
+ (instancetype)viewWithImagesArray:(NSArray <UIImage *>*)imagesArray;

@end
