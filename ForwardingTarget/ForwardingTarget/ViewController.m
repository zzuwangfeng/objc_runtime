//
//  ViewController.m
//  ForwardingTarget
//
//  Created by JackWong on 2016/12/21.
//  Copyright © 2016年 fengchaoedu. All rights reserved.
//

#import "ViewController.h"
#import "CA.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CA *ca = [CA new];
    NSString *s  = [ca performSelector:@selector(uppercaseString)];
    NSLog(@"%@",s);
    
    [ca performSelector:@selector(t)];
    
    
    u_int               count;
    objc_property_t*    properties= class_copyPropertyList([UIView class], &count);
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        NSString *strName = [NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSLog(@"%@",strName);
    }

    u_int               count1;
    Method*    methods= class_copyMethodList([UIView class], &count1);
    for (int i = 0; i < count1 ; i++)
    {
        SEL name = method_getName(methods[i]);
        NSString *strName = [NSString  stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        NSLog(@"%@",strName);
    }
}

- (void)t{
    NSLog(@"hello world");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
