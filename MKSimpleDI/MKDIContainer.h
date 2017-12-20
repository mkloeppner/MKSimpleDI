//
//  MKDIContainer.h
//  MKSimpleDI
//
//  Created by Martin Kloeppner on 20/11/16.
//  Copyright © 2016 Martin Kloeppner. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * _Nonnull const MKDIInjectionException;
extern NSString * _Nonnull const MKDINonMemberOfClassException;
extern NSString * _Nonnull const MKDINonConfirmingClassException;

@interface MKDIContainer : NSObject 

- (void)registerObject:(id<NSObject> _Nonnull)object;
- (void)registerObject:(id<NSObject> _Nonnull)object forClass:(Class _Nonnull)clazz;
- (void)registerObject:(id<NSObject> _Nonnull)object forProtocol:(Protocol * _Nonnull)protocol;

- (void)registerClass:(Class _Nonnull)clazz;
- (void)registerClass:(Class _Nonnull)clazz forProtocol:(Protocol * _Nonnull)protocol;

- (void)registerBlock:(id _Nullable (^ _Nonnull)(MKDIContainer * _Nonnull container))creation forProtocol:(Protocol *_Nullable)protocol;
- (void)registerBlock:(id _Nullable (^ _Nonnull)(MKDIContainer * _Nonnull container))creation forClass:(Class _Nonnull)clazz;

- (void)overrideObject:(id<NSObject> _Nonnull)object forClass:(Class _Nonnull)clazz;
- (void)overrideObject:(id<NSObject> _Nonnull)object forProtocol:(Protocol * _Nonnull)protocol;

- (void)overrideClass:(Class _Nonnull)clazz forProtocol:(Protocol * _Nonnull)protocol;
- (void)overrideBlock:(id _Nullable (^ _Nonnull)(MKDIContainer * _Nonnull container))creation forProtocol:(Protocol * _Nonnull)protocol;
- (void)overrideBlock:(id _Nullable (^ _Nonnull)(MKDIContainer * _Nonnull container))creation forClass:(Class _Nonnull)clazz;

- (id _Nullable)resolveForProtocol:(Protocol * _Nonnull)protocol;
- (id _Nullable)resolveForClass:(Class _Nonnull)clazz;

@end
