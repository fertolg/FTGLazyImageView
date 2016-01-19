//
//  FTGLazyImageView.swift
//  FTGLazyImageView
//
//  Created by Fernando Toledo on 1/18/16.
//  Copyright © 2016 Fernando Toledo. All rights reserved.
//

import Foundation
import UIKit

public class FTGLazyImageView: UIImageView {
    
//MARK:- Private Properties
    
    private var sessionTask: NSURLSessionTask? = nil
    
//MARK: Public Properties
    
    // read only
    private(set) var downloading: Bool = false
    private(set) var downloaded: Bool = false
    
    // read & write
    public var imageURL: NSURL? {
        didSet {
            if self.imageURL != oldValue {
                if self.downloading {
                    self.cancelDownload()
                }
                self.image = self.placeholderImage
                self.downloaded = false
            }
        }
    }
    public var placeholderImage:UIImage? {
        didSet {
            if !self.downloaded {
                self.image = self.placeholderImage
            }
        }
    }
    public var animatedTransition: Bool = true
    public var transitionDuration:CFTimeInterval = 0.25
    public var completionHandler: (imageView: FTGLazyImageView, result: FTGLazyImageResult) -> Void = { _ in }
    
//MARK:- View Lifecycle
    
    required public init?(coder aDecoder: NSCoder) {
        self.placeholderImage = nil
        self.imageURL = nil
        super.init(coder: aDecoder)
        
    }
    
    public init(imageURL: NSURL, placeholderImage: UIImage?) {
        self.imageURL = imageURL
        self.placeholderImage = placeholderImage
        super.init(image: placeholderImage)
    }
    
//MARK:- Network Support
    
    public func startDownload() {
        if self.imageURL == nil {
            return;
        }
        
        if self.downloading {
            self.cancelDownload()
        }
        
        // setup network request
        let request = NSURLRequest(URL: self.imageURL!)
        self.sessionTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            
            self.downloading = false
            
            if let data = data, image = UIImage(data: data) {
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    if self.animatedTransition {
                        let transition = CATransition()
                        transition.duration = self.transitionDuration
                        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                        transition.type = kCATransitionFade
                        self.layer .addAnimation(transition, forKey: nil)
                    }
                    
                    self.image = image
                    self.downloaded = true
                    
                    let result = FTGLazyImageResult.Success(data: data, response: response, error: error)
                    self.completionHandler(imageView: self, result: result)
                })
            } else {
                let result = FTGLazyImageResult.Failure(data: data, response: response, error: error)
                self.completionHandler(imageView: self, result: result)
            }
        })
        
        self.sessionTask?.resume()
        self.downloading = true
    }
    
    public func cancelDownload() {
        if self.downloading {
            if let sessionTask = self.sessionTask {
                sessionTask.cancel()
                self.sessionTask = nil
                self.downloading = false
            }
        }
    }

}