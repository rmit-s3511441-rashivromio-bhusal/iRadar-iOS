//
//  iRadarUITests.m
//  iRadarUITests
//
//  Created by Rashiv Romio Bhusal on 1/6/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface iRadarUITests : XCTestCase

@end

@implementation iRadarUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testExample {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *normalStartButton = app.buttons[@"Normal Start"];
    [normalStartButton tap];
    [app.buttons[@"Back"] tap];
    [normalStartButton tap];
    [app.buttons[@"Continue"] tap];
    
    XCUIElement *mainlandButtersoft375gStaticText = app.tables.staticTexts[@"Mainland Buttersoft 375g"];
    [mainlandButtersoft375gStaticText swipeLeft];
    [mainlandButtersoft375gStaticText tap];
    [mainlandButtersoft375gStaticText tap];
    [app.buttons[@"Good             * * * * * "] tap];
    
    XCUIElement *backButton = app.navigationBars[@"iRadar.NormalAdvertisementView"].buttons[@"Back"];
    [backButton tap];
    [mainlandButtersoft375gStaticText swipeLeft];
    [mainlandButtersoft375gStaticText swipeLeft];
    [mainlandButtersoft375gStaticText swipeLeft];
    [backButton tap];
    [mainlandButtersoft375gStaticText tap];
    [mainlandButtersoft375gStaticText tap];
    [mainlandButtersoft375gStaticText swipeLeft];
    [mainlandButtersoft375gStaticText swipeLeft];
    [mainlandButtersoft375gStaticText tap];
    [mainlandButtersoft375gStaticText swipeLeft];
    [app.navigationBars[@"iRadar.NormalTableView"].buttons[@"Back"] tap];
    [[[XCUIApplication alloc] init].buttons[@"GIDSignInButton"] tap];
    
    //XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *clickToShareButton = app.tables.buttons[@"Click to Share"];
    [clickToShareButton tap];
    
    XCUIElementQuery *sheetsQuery = app.sheets;
    [sheetsQuery.buttons[@"Facebook"] tap];
    [app.keys[@"A"] tap];
    [[app.scrollViews childrenMatchingType:XCUIElementTypeTextView].element typeText:@"A"];
    [app.navigationBars[@"Facebook"].buttons[@"Post"] tap];
    [clickToShareButton tap];
    [sheetsQuery.buttons[@"Twitter"] tap];
    [app.navigationBars[@"Twitter"].buttons[@"Post"] tap];
    [[[XCUIApplication alloc] init].navigationBars[@"Advertisement1"].buttons[@"Advertisement"] tap];
    
   // XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"I did not like         * "] tap];
    [app.navigationBars[@"Advertisement1"].buttons[@"Advertisement"] tap];
    [app.navigationBars[@"Advertisement"].buttons[@"Signout"] tap];
    
    XCUIElement *okButton = app.alerts[@"Title"].buttons[@"OK"];
    [okButton tap];
    [okButton tap];
    [app.buttons[@"Normal Start"] tap];
    [app.buttons[@"Continue"] tap];
    
   // XCUIElement *mainlandButtersoft375gStaticText = app.tables.staticTexts[@"Mainland Buttersoft 375g"];
    [mainlandButtersoft375gStaticText tap];
    [mainlandButtersoft375gStaticText tap];
    [app.buttons[@"Average          * * * "] tap];
    [app.navigationBars[@"iRadar.NormalAdvertisementView"].buttons[@"Back"] tap];
    [app.navigationBars[@"iRadar.NormalTableView"].buttons[@"Back"] tap];
    [[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:2] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element.buttons[@"Back"] tap];
    
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)myTestAlert {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


@end
