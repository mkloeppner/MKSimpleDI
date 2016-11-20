//
//  ABServiceWrapper.h
//  MKSimpleDI
//
//  Created by Martin Klöppner on 20/11/2016.
//  Copyright © 2016 Martin Kloeppner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABService.h"

@interface ABServiceWrapper : NSObject

@property (strong, nonatomic) ABService *abService;

- (instancetype)initWith:(ABService *)abService;

@end
