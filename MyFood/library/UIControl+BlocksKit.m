//
//  UIControl+BlocksKit.m
//  MyFood
//
//  Created by qunlee on 16/8/31.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "UIControl+BlocksKit.h"
#import <objc/runtime.h>

static const void *BKControlHandlersKey = &BKControlHandlersKey;

@interface BKControlWrapper : NSObject<NSCopying>
- (id)initWithHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;
@property (nonatomic, copy) void (^handler)(id sender);
@property (nonatomic) UIControlEvents controlEvents;
@end
@implementation BKControlWrapper

- (id)initWithHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents
{
    self = [super init];
    if (!self) return nil;
    
    self.handler = handler;
    self.controlEvents = controlEvents;
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    return [[BKControlWrapper alloc] initWithHandler:self.handler forControlEvents:self.controlEvents];
}

- (void)invoke:(id)sender
{
    self.handler(sender);
}


@end

@implementation UIControl (BlocksKit)

- (void)bk_addEventHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents{
    NSParameterAssert(handler);
    
    NSMutableDictionary *events = objc_getAssociatedObject(self, BKControlHandlersKey);
    if (!events) {
        events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, BKControlHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSNumber *key = @(controlEvents);
    NSMutableSet *handlers = events[key];
    if (!handlers) {
        handlers = [NSMutableSet set];
        events[key] = handlers;
    }
    
    BKControlWrapper *target = [[BKControlWrapper alloc] initWithHandler:handler forControlEvents:controlEvents];
    [handlers addObject:target];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
}
- (void)bk_removeEventHandlersForControlEvents:(UIControlEvents)controlEvents
{
    NSMutableDictionary *events = objc_getAssociatedObject(self, BKControlHandlersKey);
    if (!events) {
        events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, BKControlHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSNumber *key = @(controlEvents);
    NSSet *handlers = events[key];
    
    if (!handlers)
        return;
    
    [handlers enumerateObjectsUsingBlock:^(id sender, BOOL *stop) {
        [self removeTarget:sender action:NULL forControlEvents:controlEvents];
    }];
    
    [events removeObjectForKey:key];
}

- (BOOL)bk_hasEventHandlersForControlEvents:(UIControlEvents)controlEvents
{
    NSMutableDictionary *events = objc_getAssociatedObject(self, BKControlHandlersKey);
    if (!events) {
        events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, BKControlHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSNumber *key = @(controlEvents);
    NSSet *handlers = events[key];
    
    if (!handlers)
        return NO;
    
    return !!handlers.count;
}

@end
