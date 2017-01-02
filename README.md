# CyclicScrollView
图片轮播器

简介
-----------------
###属性
* `NSTimeInterval interval:`定时间隔，时间间隔默认为2秒
* `NSArray *imagesArray：`图片数组

### 创建实例
* 对象方法<br />

> \- (instancetype)initWithImagesArray:(NSArray *)imagesArray;

初始化时为避免图片数组被无意修改，会生成一个新的数组<br />
```
- (void)setImagesArray:(NSArray *)imagesArray {
       _imagesArray = [NSArray arrayWithArray:imagesArray];
}
```
* 类方法


> \+ (instancetype)viewWithImagesArray:(NSArray *)imagesArray;

### 定时器
定时器使用的是我自己封装的GCD定时器，有兴趣的朋友可以前往[https://github.com/Shanhi/GCDTimer](https://github.com/Shanhi/GCDTimer)浏览
