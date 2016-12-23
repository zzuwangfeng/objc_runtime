//
//  CA.m
//  ForwardingTarget
//
//  Created by JackWong on 2016/12/21.
//  Copyright © 2016年 fengchaoedu. All rights reserved.
//

#import "CA.h"
#import <objc/runtime.h>
#import "ViewController.h"
@implementation CA
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
    if (!methodSignature) {
        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:*"];
    }
    return methodSignature;
}
- (void)forwardInvocation:(NSInvocation *)anInvocation  {
    ViewController *messageForwarding = [ViewController new];
    if ([messageForwarding respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:messageForwarding];
    }
}
- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    if( aSelector == @selector(uppercaseString) ){
        return @"hello world";
    }
    
    return nil;
    
}

void dynamicMethodIMP(id SELF,SEL __cmd) {
    
    printf("SEL %s \n", sel_getName(__cmd));
    
}
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    NSLog(@"##########3");
    
//    if( sel == @selector(t) ) {
//        class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "v@:");
//    }
//    
//    return [super resolveInstanceMethod:sel];
    
    return YES;
}


@end
