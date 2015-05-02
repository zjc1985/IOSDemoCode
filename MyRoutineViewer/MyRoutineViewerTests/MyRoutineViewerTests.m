//
//  MyRoutineViewerTests.m
//  MyRoutineViewerTests
//
//  Created by bizappman on 4/30/15.
//  Copyright (c) 2015 yufu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RoutineManager.h"
@interface MyRoutineViewerTests : XCTestCase

@property(nonatomic,strong)RoutineManager *dbManager;

@end

@implementation MyRoutineViewerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.dbManager=[RoutineManager sharedManager];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testQueryRoutineByUUID {
    NSString *uuid=@"2EA04CEA-4774-4AB2-B6B9-E940D0106CCC";
    Routine *routine=[self.dbManager queryRoutineWithUUID:uuid];
    NSLog(@"routine title %@",routine.title);
    NSLog(@"marker count %u",[routine.markers count]);
    XCTAssertNotNil(routine);
}

-(void)testQueryMarkerByUUID{
    NSString *uuid=@"98D07EA9-D53C-4EE5-AFAB-2E9415048A87";
    Marker *marker=[self.dbManager fetchMarkerByUUID:uuid];
    XCTAssertNotNil(marker);
    XCTAssertNotNil(marker.belongRoutine);
    NSLog(@"belong routine title %@",marker.belongRoutine.title);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
