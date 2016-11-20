//
//  MKDIContainer.h
//  MKSimpleDI
//
//  Created by Martin Kloeppner on 20/11/16.
//  Copyright © 2016 Martin Kloeppner. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const MKDINonMemberOfClassException;
extern NSString * const MKDINonConfirmingClassException;

@interface MKDIContainer : NSObject

- (void)registerObject:(id<NSObject>)object;
- (void)registerObject:(id<NSObject>)object forClass:(Class)clazz;
- (void)registerObject:(id<NSObject>)object forProtocol:(Protocol *)protocol;

- (void)registerClass:(Class)clazz;
- (void)registerClass:(Class)clazz forProtocol:(Protocol *)protocol;

- (void)registerBlock:(id (^)(MKDIContainer *))creation forProtocol:(Protocol *)protocol;
- (void)registerBlock:(id (^)(MKDIContainer *))creation forClass:(Class)clazz;

- (void)overrideObject:(id<NSObject>)object forClass:(Class)clazz;
- (void)overrideObject:(id<NSObject>)object forProtocol:(Protocol *)protocol;

- (void)overrideClass:(Class)clazz forProtocol:(Protocol *)protocol;
- (void)overrideBlock:(id (^)(MKDIContainer *))creation forProtocol:(Protocol *)protocol;
- (void)overrideBlock:(id (^)(MKDIContainer *))creation forClass:(Class)clazz;

- (id)resolveForProtocol:(Protocol *)protocol;
- (id)resolveForClass:(Class)clazz;

@end
