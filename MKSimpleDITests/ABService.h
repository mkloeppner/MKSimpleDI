//
//  ABService.h
//  MKSimpleDI
//
//  Created by Martin Klöppner on 20/11/2016.
//  Copyright © 2016 Martin Kloeppner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "A.h"
#import "B.h"

@interface ABService : NSObject

@property (strong, nonatomic, readonly) id<A> a;
@property (strong, nonatomic, readonly) id<B> b;

- (instancetype)initWith:(id<A>)a and:(id<B>)b;

@end
