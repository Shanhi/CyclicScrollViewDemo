//
//  CyclicScrollView.m
//  CyclicScrollView
//
//  Created by sShan on 16/12/26.
//  Copyright © 2016年 sShan. All rights reserved.
//

#import "CyclicScrollView.h"
#import "CyclicCollectionViewLayout.h"
#import "CyclicCollectionViewCell.h"
#import "GCD_Timer.h"

@interface CyclicScrollView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) GCD_Timer *GCDTimer;

@end

@implementation CyclicScrollView
- (void)dealloc {
    NSLog(@"dealloc");
}

+ (instancetype)viewWithImagesArray:(NSArray *)imagesArray {
    return [[[self class]alloc]initWithImagesArray:imagesArray];
}

- (instancetype)initWithImagesArray:(NSArray *)imagesArray {
    if (self = [super init]) {
        self.imagesArray = imagesArray;
        [self loadCollectionViewAndTimer];
    }
    return self;
}

- (void)setImagesArray:(NSArray *)imagesArray {
    _imagesArray = [NSArray arrayWithArray:imagesArray];
    NSLog(@"\n:::CyclicScrollView.imagesArray:::\n%@", self.imagesArray);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadCollectionViewAndTimer];
    }
    return self;
}

- (void)loadCollectionViewAndTimer {
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:[CyclicCollectionViewLayout new] ];
    [collectionView registerClass:[CyclicCollectionViewCell class] forCellWithReuseIdentifier:@"CyclicCollectionViewCell"];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    self.collectionView = collectionView;
    [self addSubview:collectionView];
    //block在主线程空闲时执行
    dispatch_async(dispatch_get_main_queue(), ^{
        [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.imagesArray.count inSection:0] atScrollPosition:0 animated:NO];
        
        if (self.GCDTimer == nil) {
            self.interval = self.interval ? self.interval : 2;
            __weak typeof(self) weakSelf = self;
            self.GCDTimer = [GCD_Timer timerWithInterval:self.interval repeats:YES task:^{
                [weakSelf nextImage];
            }];
            [self.GCDTimer resumeTimer];
        }
    });
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

- (void)nextImage {
    NSLog(@"%.1f秒后定时器下一张", self.GCDTimer.interval);
    CGFloat newOffsetX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width;
    [self.collectionView setContentOffset:CGPointMake(newOffsetX, 0) animated:YES];
}

#pragma mark - UICollectionViewDataSource 

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CyclicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CyclicCollectionViewCell" forIndexPath:indexPath];
    cell.image = self.imagesArray[indexPath.item % self.imagesArray.count];
//    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagesArray.count*2;
}

#pragma mark - UICollectionViewDelegate继承于UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger page = scrollView.contentOffset.x / self.bounds.size.width;
    if (page == 0) {
        [self secretlyScroll:scrollView ToPage:self.imagesArray.count];
    } else if (page == (self.imagesArray.count*2 - 1)) {
        [self secretlyScroll:scrollView ToPage:(self.imagesArray.count-1)];
    }
}

- (void)secretlyScroll:(UIScrollView *)scrollView ToPage:(NSUInteger)page {
    CGFloat targetOffset = page*self.bounds.size.width;
    [scrollView setContentOffset:CGPointMake(targetOffset, 0) animated:NO];
}

#pragma mark - 用于定时器的UIScrollViewDelegate方法

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.GCDTimer removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.GCDTimer resumeTimer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
