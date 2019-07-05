//
//  ImageSizeAfterTransformDemoTests.swift
//  ImageSizeAfterTransformDemoTests
//
//  Created by nullLuli on 2019/7/5.
//  Copyright © 2019 nullLuli. All rights reserved.
//

import XCTest
@testable import ImageSizeAfterTransformDemo

class ImageSizeAfterTransformDemoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let trans = CGAffineTransform.identity.rotated(by: CGFloat(Double.pi / 4))
        let frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        let frameAfter = frame.applying(trans)
        let frameAfter2 = ViewController.caculateFrame(frame: frame, after: trans)
        print(frameAfter)
        print(frameAfter2)
    }
    

}
