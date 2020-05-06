//
//  XZViewController.m
//  XZCustomKVO
//
//  Created by Alan on 4/29/20.
//  Copyright © 2020 zhaixingzhi. All rights reserved.
//

#import "XZViewController.h"
#import "XZPerson.h"
#import "NSObject+XZKVO.h"
#import <objc/runtime.h>

@interface XZViewController ()
@property (nonatomic, strong) XZPerson *person;

@end

@implementation XZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [[XZPerson alloc] init];
   
    [self.person xz_addObserver:self forKeyPath:@"nickName" options:(NSKeyValueObservingOptionOld) context:NULL handle:^(id  _Nonnull observer, NSString * _Nonnull keyPath, id  _Nonnull oldValue, id  _Nonnull newValue) {
        NSLog(@"nickName: oldvalue-- %@ newValue---%@",oldValue,newValue);
    }];
    [self.person xz_addObserver:self forKeyPath:@"address" options:(NSKeyValueObservingOptionNew) context:NULL handle:^(id  _Nonnull observer, NSString * _Nonnull keyPath, id  _Nonnull oldValue, id  _Nonnull newValue) {
        NSLog(@"address: oldvalue-- %@ newValue---%@",oldValue,newValue);

    }];
    self.person.nickName = @"xing";
    self.person.address = @"beijing";

    // Do any additional setup after loading the view.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.person.nickName = @"alan";
    self.person.address = @"shanxi";
}

- (void)dealloc{
    // 这里我们不想操作了我们的销毁代码
    // 我们就想把销毁的代码隐藏起来
    // 我们就在分类重写dealloc --- 两个问题
    // -| 我们要想dealloc 就需要这个对象销毁 --
    // -| 我们分类重写会导致所有的类都交换了
    
    NSLog(@"销毁 走你");

//    [self.person xz_removeObserver:self forKeyPath:@"nickName"];
//    [self.person xz_removeObserver:self forKeyPath:@"address"];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
