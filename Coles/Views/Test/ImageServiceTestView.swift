import SwiftUI

struct ImageServiceTestView: View {
    @State private var imageURL: String = "https://www.coles.com.au/content/dam/coles/inspire-create/thumbnails/Tomato-and-bread-salad-480x288.jpg"
    @State private var shouldLoadImage: Bool = false
    
    // Sample URLs for testing
    private let sampleURLs = [
        "https://picsum.photos/400/300",
        "https://picsum.photos/400/400",
        "https://picsum.photos/500/300"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Image Service Test")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                // URL Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Image URL:")
                        .font(.headline)
                    
                    TextField("Enter image URL", text: $imageURL)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                }
                .padding(.horizontal)
                
                // Sample URLs
                VStack(alignment: .leading, spacing: 8) {
                    Text("Sample URLs:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    ForEach(sampleURLs, id: \.self) { url in
                        Button(action: {
                            imageURL = url
                        }) {
                            Text(url)
                                .font(.caption)
                                .foregroundColor(.blue)
                                .lineLimit(1)
                                .truncationMode(.middle)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Fetch Button
                Button(action: {
                    shouldLoadImage = true
                }) {
                    Text("Load Image")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(imageURL.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(imageURL.isEmpty)
                .padding(.horizontal)
                
                // Image Display using RemoteImage
                if shouldLoadImage && !imageURL.isEmpty {
                    VStack(spacing: 12) {
                        Text("Fetched Image:")
                            .font(.headline)
                        
                        RemoteImage(url: imageURL) {
                            ProgressView()
                                .frame(height: 200)
                        } errorView: { error in
                            VStack(spacing: 8) {
                                Image(systemName: "exclamationmark.triangle")
                                    .font(.largeTitle)
                                    .foregroundColor(.red)
                                Text(error)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                        }
                        .scaledToFit()
                        .padding(.horizontal)
                    }
                    
                    // Clear Cache Button
                    Button(action: {
                        clearCache()
                    }) {
                        Text("Clear Cache & Reset")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
        }
    }
    
    private func clearCache() {
        ImageService.shared.clearCache()
        shouldLoadImage = false
    }
}

#Preview {
    ImageServiceTestView()
}

