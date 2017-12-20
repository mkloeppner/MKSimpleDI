//
//  ABService.m
//  MKSimpleDI
//
//  Created by Martin Klöppner on 20/11/2016.
//  Copyright © 2016 Martin Kloeppner. All rights reserved.
//

#import "ABService.h"

@interface ABService ()

@property (strong, nonatomic, readwrite) id<A> a;
@property (strong, nonatomic, readwrite) id<B> b;

@end

@implementation ABService

- (instancetype)initWith:(id<A>)a and:(id<B>)b
{
    self = [super init];
    if (self) {
        self.a = a;
        self.b = b;
    }
    return self;
}

@end
