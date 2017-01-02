//
//  CyclicCollectionViewCell.m
//  CyclicScrollView
//
//  Created by sShan on 16/12/26.
//  Copyright © 2016年 sShan. All rights reserved.
//

#import "CyclicCollectionViewCell.h"

@interface CyclicCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CyclicCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]initWithFrame:frame];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

@end
