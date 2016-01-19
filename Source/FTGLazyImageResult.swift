//
//  FTGLazyImageLoadingError.swift
//  FTGLazyImageView
//
//  Created by Fernando Toledo on 1/19/16.
//  Copyright © 2016 Fernando Toledo. All rights reserved.
//

import Foundation
import UIKit

public enum FTGLazyImageResult {
    case Success(data: NSData?, response: NSURLResponse?, error: NSError?)
    case Failure(data: NSData?, response: NSURLResponse?, error: NSError?)
    
    public var isSuccess: Bool {
        switch self {
            case .Success:
                return true;
            case .Failure:
                return false;
        }
    }
    
    public var isFailure: Bool {
        return !self.isSuccess
    }
    
    public var data: NSData? {
        switch self {
            case .Success(let data, _, _):
                return data
            case .Failure(let data, _, _):
                return data
        }
    }
    
    public var response: NSURLResponse? {
        switch self {
            case .Success(_, let response, _):
                return response
            case .Failure(_, let response, _):
                return response
        }
    }
    
    public var error: NSError? {
        switch self {
        case .Success(_, _, let error):
            return error
        case .Failure(_, _, let error):
            return error
        }
    }
}