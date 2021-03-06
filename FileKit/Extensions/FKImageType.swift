//
//  FKImageType.swift
//  FileKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Nikolai Vazquez
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#if os(OSX)
import Cocoa
public typealias FKImageType = NSImage
#elseif os(iOS) || os(tvOS)
import UIKit
public typealias FKImageType = UIImage
#else
import WatchKit
public typealias FKImageType = UIImage
#endif

extension FKImageType : FKDataType, FKWritableConvertible {

    public class func readFromPath(path: FKPath) throws -> Self {
        guard let contents = self.init(contentsOfFile: path.rawValue) else {
            throw FKError.ReadFromFileFail(path: path)
        }
        return contents
    }

    public var writable: NSData? {
        #if os(OSX)
        return self.TIFFRepresentation
        #else
        return UIImagePNGRepresentation(self)
        #endif
    }

}
