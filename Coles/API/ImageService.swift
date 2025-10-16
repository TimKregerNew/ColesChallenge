import Foundation
import UIKit

enum ImageServiceError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case networkError(Error)
}

class ImageService {
    static let shared = ImageService()
    
    private let urlSession: URLSession
    private let cache = NSCache<NSString, UIImage>()
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
        // Configure cache limits
        cache.countLimit = 100
        cache.totalCostLimit = 50 * 1024 * 1024 // 50 MB
    }
    
    func fetchImageData(from urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw ImageServiceError.invalidURL
        }
        
        return try await fetchImageData(from: url)
    }
    
    func fetchImageData(from url: URL) async throws -> Data {
        do {
            let (data, response) = try await urlSession.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw ImageServiceError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw ImageServiceError.invalidResponse
            }
            
            guard !data.isEmpty else {
                throw ImageServiceError.invalidData
            }
            
            return data
        } catch let error as ImageServiceError {
            throw error
        } catch {
            throw ImageServiceError.networkError(error)
        }
    }
    
    func fetchImage(from urlString: String) async throws -> UIImage {
        // Check cache first
        let cacheKey = urlString as NSString
        if let cachedImage = cache.object(forKey: cacheKey) {
            return cachedImage
        }
        
        // Fetch image data
        let data = try await fetchImageData(from: urlString)
        
        guard let image = UIImage(data: data) else {
            throw ImageServiceError.invalidData
        }
        
        // Cache the image
        cache.setObject(image, forKey: cacheKey)
        
        return image
    }
    
    /// Clears the image cache
    func clearCache() {
        cache.removeAllObjects()
    }
}

