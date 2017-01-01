//
//  CyclicScrollViewLayout.m
//  CyclicScrollView
//
//  Created by sShan on 16/12/26.
//  Copyright © 2016年 sShan. All rights reserved.
//

#import "CyclicCollectionViewLayout.h"

@implementation CyclicCollectionViewLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.itemSize = self.collectionView.bounds.size;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.pagingEnabled = YES;
    
    self.minimumLineSpacing = 0;
//    self.minimumInteritemSpacing = 0;
//    self.collectionView.showsVerticalScrollIndicator = NO;
//    self.collectionView.showsHorizontalScrollIndicator = NO;
}

@end
