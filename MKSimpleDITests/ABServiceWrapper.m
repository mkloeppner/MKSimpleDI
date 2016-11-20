//
//  ABServiceWrapper.m
//  MKSimpleDI
//
//  Created by Martin Klöppner on 20/11/2016.
//  Copyright © 2016 Martin Kloeppner. All rights reserved.
//

#import "ABServiceWrapper.h"

@implementation ABServiceWrapper

- (instancetype)initWith:(ABService *)abService
{
    self = [super init];
    if (self) {
        _abService = abService;
    }
    return self;
}

@end
