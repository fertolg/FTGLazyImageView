//
//  FTGLazyImageViewTests.swift
//  FTGLazyImageViewTests
//
//  Created by Fernando Toledo on 1/18/16.
//  Copyright © 2016 Fernando Toledo. All rights reserved.
//

import XCTest
import FTGLazyImageView

class FTGLazyImageViewTests: XCTestCase {
    
    func testImageDownload() {
        let url = NSURL(string: "http://images.apple.com/home/images/og.jpg")
        let expectation = expectationWithDescription("load image")
        let lazyLoadingImage = FTGLazyImageView(imageURL: url!, placeholderImage: nil)
        
        lazyLoadingImage.completionHandler = {
            (imageView, result) in
            
            XCTAssertTrue(result.isSuccess)
            XCTAssertNotNil(imageView.image)
            
            expectation.fulfill()
        }
        
        lazyLoadingImage.startDownload()
        
        waitForExpectationsWithTimeout(5, handler: {
            (error) in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        })
    }
    
    func testImage404() {
        let url = NSURL(string: "http://onehungryfool.net/image.jpg")
        let expectation = expectationWithDescription("image not found")
        let lazyLoadingImage = FTGLazyImageView(imageURL: url!, placeholderImage: nil)
        
        lazyLoadingImage.completionHandler = {
            (imageView, result) in
            
            XCTAssertTrue(result.isFailure)
            if let httpResponse = result.response as? NSHTTPURLResponse {
                XCTAssertEqual(httpResponse.statusCode, 404)
            } else {
                XCTFail("Response was not NSHTTPURLResponse")
            }
            XCTAssertNil(imageView.image)
            
            expectation.fulfill()
        }
        
        lazyLoadingImage.startDownload()
        
        waitForExpectationsWithTimeout(5, handler: {
            (error) in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        })
    }
    
    func testNonExistentDomain() {
        let url = NSURL(string: "http://nonexistentimagedomain.com/image.jpg")
        let expectation = expectationWithDescription("domain doesn't exist")
        let lazyLoadingImage = FTGLazyImageView(imageURL: url!, placeholderImage: nil)
        
        lazyLoadingImage.completionHandler = {
            (imageView, result) in
            
            XCTAssertTrue(result.isFailure)
            XCTAssertNil(result.response)
            XCTAssertNil(imageView.image)
            
            expectation.fulfill()
        }
        
        lazyLoadingImage.startDownload()
        
        waitForExpectationsWithTimeout(5, handler: {
            (error) in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        })
    }
    
    func testNotAnImage() {
        let url = NSURL(string: "http://onehungryfool.net")
        let expectation = expectationWithDescription("not an image")
        let lazyLoadingImage = FTGLazyImageView(imageURL: url!, placeholderImage: nil)
        
        lazyLoadingImage.completionHandler = {
            (imageView, result) in
            
            XCTAssertTrue(result.isFailure)
            XCTAssertNil(imageView.image)
            
            expectation.fulfill()
        }
        
        lazyLoadingImage.startDownload()
        
        waitForExpectationsWithTimeout(5, handler: {
            (error) in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        })
    }
    
}
