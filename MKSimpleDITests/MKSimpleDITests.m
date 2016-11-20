//
//  MKSimpleDITests.m
//  MKSimpleDITests
//
//  Created by Martin Kloeppner on 20/11/16.
//  Copyright © 2016 Martin Kloeppner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MKSimpleDI.h"
#import "ClassA.h"
#import "ClassB.h"

@interface MKSimpleDITests : XCTestCase

@property (strong, nonatomic) MKDIContainer *container;

@end

@implementation MKSimpleDITests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _container = [[MKDIContainer alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testResolveInstanceForProtocolByClass {
    [_container registerClass:[ClassA class] forProtocol:@protocol(A)];
    
    id<A> a = [_container resolveForProtocol:@protocol(A)];
    XCTAssertNotNil(a);
    XCTAssertTrue([a conformsToProtocol:@protocol(A)]);
}


@end
