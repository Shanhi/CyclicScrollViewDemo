//
//  ViewController.m
//  CyclicScrollViewDemo
//
//  Created by sShan on 16/12/30.
//  Copyright © 2016年 Shan. All rights reserved.
//

#import "ViewController.h"
#import "CyclicScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *imageArr = [NSMutableArray array];
    for (int j=0; j<5; j++) {
        [imageArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d", j+1]]];
    }
    NSLog(@"%@", imageArr);
    
    CyclicScrollView *cyclicScrollView = [CyclicScrollView viewWithImagesArray:imageArr];
    cyclicScrollView.frame = CGRectMake(0, 300, self.view.frame.size.width, 150);
    cyclicScrollView.interval = 1;
    
    [self.view addSubview:cyclicScrollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
