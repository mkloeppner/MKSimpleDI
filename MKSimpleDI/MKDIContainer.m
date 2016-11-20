//
//  MKDIContainer.m
//  MKSimpleDI
//
//  Created by Martin Kloeppner on 20/11/16.
//  Copyright © 2016 Martin Kloeppner. All rights reserved.
//

#import "MKDIContainer.h"

@interface MKDIContainer ()

@property (strong, nonatomic) NSMutableDictionary<NSString *, NSString *> *classIndex;
@property (strong, nonatomic) NSMutableDictionary<NSString *, id(^)(MKDIContainer *)> *creationIndex;
@property (strong, nonatomic) NSMutableDictionary<NSString *, id> *objectStore;

@end

@implementation MKDIContainer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.classIndex = [[NSMutableDictionary<NSString *, NSString *> alloc] init];
        self.creationIndex = [[NSMutableDictionary<NSString *, id(^)(MKDIContainer *)> alloc] init];
        self.objectStore = [[NSMutableDictionary<NSString *, id> alloc] init];
    }
    return self;
}

- (void)registerObject:(id<NSObject>)object
{
    [self registerObject:object forClass:[object class]];
}

- (void)registerObject:(id<NSObject>)object forProtocol:(Protocol *)protocol
{
    [self registerObject:object forIdentifier:NSStringFromProtocol(protocol)];
}

- (void)registerObject:(id<NSObject>)object forClass:(Class)clazz
{
    [self registerObject:object forIdentifier:NSStringFromClass(clazz)];
}

- (void)registerClass:(Class)clazz
{
    NSString *key = NSStringFromClass(clazz);
    [self registerClass:clazz forIdentifier:key];
}

- (void)registerClass:(Class)clazz forProtocol:(Protocol *)protocol
{
    [self registerClass:clazz forIdentifier:NSStringFromProtocol(protocol)];
}

- (void)registerBlock:(id (^)(MKDIContainer *))creation forProtocol:(Protocol *)protocol
{
    return [self registerBlock:creation forIdentifier:NSStringFromProtocol(protocol)];
}

- (void)registerBlock:(id (^)(MKDIContainer *))creation forClass:(Class)protocol
{
    return [self registerBlock:creation forIdentifier:NSStringFromClass(protocol)];
}

- (void)registerObject:(id<NSObject>)object forIdentifier:(NSString *)identifier
{
    [self assertNoImplementationForProtocolSoFar:identifier];
    self.objectStore[identifier] = object;
}

- (void)registerClass:(Class)clazz forIdentifier:(NSString *)identifier
{
    NSString *val = NSStringFromClass(clazz);
    
    [self assertNoImplementationForProtocolSoFar:identifier];
    
    self.classIndex[identifier] = val;
}

- (void)registerBlock:(id (^)(MKDIContainer *))creation forIdentifier:(NSString *)identifier
{
    [self assertNoImplementationForProtocolSoFar:identifier];
    
    self.creationIndex[identifier] = creation;
}

- (void)assertNoImplementationForProtocolSoFar:(NSString *)identifier
{
    if ([self.classIndex objectForKey:identifier]) {
        [NSException raise:@"InjectionException" format:@"A implementation for the protocol with name \"%@\" is already registered.", identifier];
    }
    if ([self.creationIndex objectForKey:identifier]) {
        [NSException raise:@"InjectionException" format:@"A implementation for the protocol with name \"%@\" is already registered.", identifier];
    }
    if ([self.objectStore objectForKey:identifier]) {
        [NSException raise:@"InjectionException" format:@"A implementation for the protocol with name \"%@\" is already registered.", identifier];
    }
}

- (void)overrideObject:(id<NSObject>)object forProtocol:(Protocol *)protocol
{
    NSString *identifier = NSStringFromProtocol(protocol);
    [self removeImplementationForIdentifier:identifier];
    [self registerObject:object forIdentifier:identifier];
}

- (void)overrideObject:(id<NSObject>)object forClass:(Class)clazz
{
    NSString *identifier = NSStringFromClass(clazz);
    [self removeImplementationForIdentifier:identifier];
    [self registerObject:object forIdentifier:identifier];
}

- (void)overrideClass:(Class)clazz forProtocol:(Protocol *)protocol
{
    NSString *identifier = NSStringFromProtocol(protocol);
    [self removeImplementationForIdentifier:identifier];
    [self registerClass:clazz forProtocol:protocol];
}

- (void)overrideBlock:(id (^)(MKDIContainer *))creation forProtocol:(Protocol *)protocol
{
    NSString *identifier = NSStringFromProtocol(protocol);
    [self removeImplementationForIdentifier:identifier];
    [self registerBlock:creation forProtocol:protocol];
}

- (void)overrideBlock:(id (^)(MKDIContainer *))creation forClass:(Class)clazz
{
    NSString *identifier = NSStringFromClass(clazz);
    [self removeImplementationForIdentifier:identifier];
    [self registerBlock:creation forClass:clazz];
}

- (void)overrideObject:(id<NSObject>)object forIdentifier:(NSString *)identifier
{
    [self removeImplementationForIdentifier:identifier];
    [self registerObject:object forIdentifier:identifier];
}

- (void)overrideClass:(Class)clazz forIdentifier:(NSString *)identifier
{
    [self removeImplementationForIdentifier:identifier];
    [self registerClass:clazz forIdentifier:identifier];
}

- (void)overrideBlock:(id (^)(MKDIContainer *))creation forIdentifier:(NSString *)identifier
{
    [self removeImplementationForIdentifier:identifier];
    [self registerBlock:creation forIdentifier:identifier];
}

- (void)removeImplementationForIdentifier:(NSString *)identifier
{
    [self.classIndex removeObjectForKey:identifier];
    [self.creationIndex removeObjectForKey:identifier];
    [self.objectStore removeObjectForKey:identifier];
}

- (id)resolveForProtocol:(Protocol *)protocol
{
    return [self resolveForIdentifier:NSStringFromProtocol(protocol)];
}

- (id)resolveForClass:(Class)class
{
    return [self resolveForIdentifier:NSStringFromClass(class)];
}

- (id)resolveForIdentifier:(NSString *)identifier {
    if ([self.objectStore objectForKey:identifier]) {
        return self.objectStore[identifier];
    } else if ([self.classIndex objectForKey:identifier]) {
        NSString *className = [self.classIndex valueForKey:identifier];
        if (className == nil) {
            return nil;
        }
        
        return [[NSClassFromString(className) alloc] init];
    } else if ([self.creationIndex objectForKey:identifier]) {
        return self.creationIndex[identifier](self);
    }
    return nil;
}

@end
