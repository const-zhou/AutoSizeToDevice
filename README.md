# AutoSizeToDevice
###使用方法
1.在需要自适应的视图上加上头文件
```
@import "UIView+AutoSizeToDevice.h"
```
2.在视图的初始化函数里面设置属性```dg_viewAutoSizeToDevice = YES;```
###示例
1.```UIViewController```中使用
```
@import "UIViewController.h"
@import "UIVew+AutoSizeToDevice.h"

- (void)viewDidLoad()
{
  [super viewDidLoad];
  self.view.dg_viewAutoSizeToDevice = YES;
}
```
2.```UIView```中使用
```
@import "UIView.h"
@import "UIView+AutoSizeToDevice.h"

- (void)awakeFromNib
{
  self.dg_viewAutoSizeToDevice = YES;
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self){
    self.dg_viewAutoSizeToDevice = YES;
  }
  return self;
}
