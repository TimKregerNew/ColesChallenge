//
//  MockImageService.swift
//  ColesTests
//
//  Created by Tim Kreger on 17/10/2025.
//

import Foundation
import UIKit
@testable import Coles

/// Mock implementation of ImageServiceProtocol for testing
public class MockImageService: ImageServiceProtocol {
    // Configurable mock data
    public var mockImage: UIImage?
    public var mockImageData: Data?
    public var shouldFail = false
    public var errorToThrow: Error = ImageServiceError.networkError(
        NSError(domain: "MockImageService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
    )
    
    public init() {}
    
    public func fetchImageData(from urlString: String) async throws -> Data {
        if shouldFail {
            throw errorToThrow
        }
        
        if let mockImageData = mockImageData {
            return mockImageData
        }
        
        // Return a simple 1x1 pixel PNG if no mock data provided
        return createTestImageData()
    }
    
    public func fetchImageData(from url: URL) async throws -> Data {
        if shouldFail {
            throw errorToThrow
        }
        
        if let mockImageData = mockImageData {
            return mockImageData
        }
        
        return createTestImageData()
    }
    
    public func fetchImage(from urlString: String) async throws -> UIImage {
        if shouldFail {
            throw errorToThrow
        }
        
        if let mockImage = mockImage {
            return mockImage
        }
        
        // Return a simple test image
        return createTestImage()
    }
    
    public func clearCache() {
        // Mock implementation - does nothing
    }
    
    // MARK: - Helper Methods
    
    private func createTestImage() -> UIImage {
        // Create a simple 1x1 red pixel image for testing
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContext(size)
        defer { UIGraphicsEndImageContext() }
        
        UIColor.red.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        
        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
    
    private func createTestImageData() -> Data {
        let image = createTestImage()
        return image.pngData() ?? Data()
    }
}

