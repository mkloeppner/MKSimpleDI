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

# pragma mark - Register object methods
- (void)testRegisterObjectReturnsObjectByResolvingObjectsClass {
    ClassA *a = [ClassA new];
    [_container registerObject:a];
    
    id resolvedA = [_container resolveForClass:[ClassA class]];
    
    XCTAssertEqual(resolvedA, a, @"Resolved objects need to match.");
}

- (void)testRegisterObjectForClassReturnsObjectByResolvingSpecifiedClass {
    ClassA *a = [ClassA new];
    [_container registerObject:a forClass:[ClassA class]];
    
    id resolvedA = [_container resolveForClass:[ClassA class]];
    
    XCTAssertEqual(resolvedA, a, @"Resolved objects need to match.");
}

- (void)testRegisterObjectForProtocolReturnsObjectByResolvingSpecifiedProtocol {
    ClassA *a = [ClassA new];
    [_container registerObject:a forProtocol:@protocol(A)];
    
    id resolvedA = [_container resolveForProtocol:@protocol(A)];
    
    XCTAssertEqual(resolvedA, a, @"Resolved objects need to match.");
}

# pragma mark - Multiple times resolve object methods
- (void)testRegisterObjectReturnsObjectByResolvingObjectsClassAlwaysReturnsTheSameInstance {
    ClassA *a = [ClassA new];
    [_container registerObject:a];
    
    id resolvedA = [_container resolveForClass:[ClassA class]];
    id resolvedA2 = [_container resolveForClass:[ClassA class]];
    id resolvedA3 = [_container resolveForClass:[ClassA class]];
    
    XCTAssertEqual(resolvedA, a, @"Resolved objects need to match.");
    XCTAssertEqual(resolvedA2, resolvedA, @"Resolved objects need to match.");
    XCTAssertEqual(resolvedA3, resolvedA2, @"Resolved objects need to match.");
}

- (void)testRegisterObjectForProtocolThrowsExceptionWhenObjectClassDoesNotConformToProtocol
{
    ClassA *a = [ClassA new];
    
    XCTAssertThrowsSpecificNamed([_container registerObject:a forProtocol:@protocol(B)], NSException, MKDINonConfirmingClassException, @"should throw an exception");
}

- (void)testRegisterObjectForClassThrowsExceptionWhenObjectClassIsNotMemberOfSpecifiedClass
{
    ClassA *a = [ClassA new];
    
    XCTAssertThrowsSpecificNamed([_container registerObject:a forClass:[ClassB class]], NSException, MKDINonMemberOfClassException, @"should throw an exception");
}

- (void)testRegisterObjectForClassReturnsObjectByResolvingSpecifiedClassAlwaysReturnsTheSameInstance {
    ClassA *a = [ClassA new];
    [_container registerObject:a forClass:[ClassA class]];
    
    id resolvedA = [_container resolveForClass:[ClassA class]];
    id resolvedA2 = [_container resolveForClass:[ClassA class]];
    id resolvedA3 = [_container resolveForClass:[ClassA class]];
    
    XCTAssertEqual(resolvedA, a, @"Resolved objects need to match.");
    XCTAssertEqual(resolvedA2, resolvedA, @"Resolved objects need to match.");
    XCTAssertEqual(resolvedA3, resolvedA2, @"Resolved objects need to match.");
    
}

- (void)testRegisterObjectForProtocolReturnsObjectByResolvingSpecifiedProtocolAlwaysReturnsTheSameInstance {
    ClassA *a = [ClassA new];
    [_container registerObject:a forProtocol:@protocol(A)];
    
    id resolvedA = [_container resolveForProtocol:@protocol(A)];
    id resolvedA2 = [_container resolveForProtocol:@protocol(A)];
    id resolvedA3 = [_container resolveForProtocol:@protocol(A)];
    
    XCTAssertEqual(resolvedA, a, @"Resolved objects need to match.");
    XCTAssertEqual(resolvedA2, resolvedA, @"Resolved objects need to match.");
    XCTAssertEqual(resolvedA3, resolvedA2, @"Resolved objects need to match.");
}

#pragma mark - Register class methods
- (void)testRegisterClassReturnsInstanceOfClassByResolvingSpecifiedClass
{
    [_container registerClass:[ClassA class]];
    
    id resolvedA = [_container resolveForClass:[ClassA class]];
    
    XCTAssertNotNil(resolvedA);
    XCTAssertTrue([resolvedA isKindOfClass:[ClassA class]]);
    XCTAssertEqual([resolvedA class], [ClassA class]);
}

- (void)testRegisterClassForProtocolReturnsInstanceOfClassByResolvingSpecifiedProtocol
{
    [_container registerClass:[ClassA class] forProtocol:@protocol(A)];
    
    id resolvedA = [_container resolveForProtocol:@protocol(A)];
    
    XCTAssertNotNil(resolvedA);
    XCTAssertTrue([resolvedA isKindOfClass:[ClassA class]]);
    XCTAssertEqual([resolvedA class], [ClassA class]);
}

- (void)testRegisterClassForProtocolThrowsExceptionWhenClassDoesNotConformToProtocol
{
    XCTAssertThrowsSpecificNamed([_container registerClass:[ClassA class] forProtocol:@protocol(B)], NSException, MKDINonConfirmingClassException, @"should throw an exception");
}

- (void)testRegisterClassReturnsInstanceOfClassByResolvingSpecifiedClassAlwaysReturnsNewInstance
{
    [_container registerClass:[ClassA class]];
    
    id resolvedA = [_container resolveForClass:[ClassA class]];
    id resolvedB = [_container resolveForClass:[ClassA class]];
    
    XCTAssertNotEqual(resolvedA, resolvedB, @"should recreate and a new instance on resolving");
}

@end
