//
//  ViewController.m
//  Runtime-class_replaceMethod
//
//  Created by JackWong on 2016/12/19.
//  Copyright © 2016年 fengchaoedu. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()

@end


@implementation ViewController

+ (void)load {
    NSLog(@"%@",NSStringFromClass([self class]));
    NSLog(@"%s",__func__);
}

+ (void)initialize {
    NSLog(@"%@",NSStringFromClass([self class]));
    NSLog(@"%s",__func__);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testReplaceMethod];
    
    __block int multiplier = 7;
    int (^myBlock)(int) = ^(int num) {
        multiplier ++;//这样就可以了
        return num * multiplier;
    };
    NSMutableArray *mArray = [NSMutableArray arrayWithObjects:@"a",@"b",@"abc",nil];
    NSMutableArray *mArrayCount = [NSMutableArray arrayWithCapacity:1];
    [mArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock: ^(id obj,NSUInteger idx, BOOL *stop){
        [mArrayCount addObject:[NSNumber numberWithInt:[obj length]]];
    }];
    
    NSLog(@"%@",mArrayCount);
    
 
}
 IMP originIMP;

NSString * swizzledString(id SELF, SEL __cmd) {
    NSLog(@"SELF————————————%@",SELF);
    NSLog(@"__cmd————————————%@",   NSStringFromSelector(__cmd) );
    NSLog(@"begin");
    NSString *str = originIMP(SELF,__cmd);
    NSLog(@"end");
    return str;
}


- (void)testReplaceMethod{
    
    Class strcls = [NSString class];
    SEL originSelector = @selector(uppercaseString);
    originIMP = [NSString instanceMethodForSelector:originSelector];
//    class_replaceMethod(strcls, originSelector, (IMP)swizzledString, NULL);
    class_addMethod(strcls, originSelector, imp_implementationWithBlock(^(id SELF,SEL  __cmd){
        NSLog(@"SELF————————————%@",SELF);
        NSLog(@"__cmd————————————%@",   NSStringFromSelector(__cmd) );
        NSLog(@"begin");
        NSString *str = originIMP(SELF,__cmd);
       
    }), NULL);
    NSString *str = @"hello world";
    NSLog(@"%@",[str uppercaseString]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
