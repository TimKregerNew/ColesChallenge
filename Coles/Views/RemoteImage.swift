import SwiftUI

struct RemoteImage: View {
    let url: String
    let placeholder: AnyView?
    let errorView: ((String) -> AnyView)?
    
    @StateObject private var loader = RemoteImageLoader()
    
    init(
        url: String,
        @ViewBuilder placeholder: () -> some View = { ProgressView() },
        @ViewBuilder errorView: @escaping (String) -> some View = { error in
            VStack {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.red)
                Text(error)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    ) {
        self.url = url
        self.placeholder = AnyView(placeholder())
        self.errorView = { error in AnyView(errorView(error)) }
    }
    
    var body: some View {
        Group {
            switch loader.state {
            case .loading:
                placeholder
                    .accessibilityHidden(true)
            case .loaded(let image):
                Image(uiImage: image)
                    .resizable()
            case .failed(let error):
                if let errorView = errorView {
                    errorView(error)
                        .accessibilityHidden(true)
                } else {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.red)
                        .accessibilityHidden(true)
                }
            }
        }
        .onAppear {
            loader.load(url: url)
        }
        .onChange(of: url) {
            loader.load(url: url)
        }
    }
}

@MainActor
class RemoteImageLoader: ObservableObject {
    enum LoadState {
        case loading
        case loaded(UIImage)
        case failed(String)
    }
    
    @Published var state: LoadState = .loading
    private var currentTask: Task<Void, Never>?
    
    func load(url: String) {
        // Cancel any existing task
        currentTask?.cancel()
        
        // Set loading state
        state = .loading
        
        // Create new task
        currentTask = Task {
            do {
                let image = try await ImageService.shared.fetchImage(from: url)
                
                // Check if task was cancelled
                guard !Task.isCancelled else { return }
                
                state = .loaded(image)
            } catch ImageServiceError.invalidURL {
                guard !Task.isCancelled else { return }
                state = .failed("Invalid URL")
            } catch ImageServiceError.invalidResponse {
                guard !Task.isCancelled else { return }
                state = .failed("Invalid response")
            } catch ImageServiceError.invalidData {
                guard !Task.isCancelled else { return }
                state = .failed("Invalid image data")
            } catch ImageServiceError.networkError(let error) {
                guard !Task.isCancelled else { return }
                state = .failed("Network error: \(error.localizedDescription)")
            } catch {
                guard !Task.isCancelled else { return }
                state = .failed("Unexpected error")
            }
        }
    }
    
    deinit {
        currentTask?.cancel()
    }
}

#Preview {
    RemoteImage(url: "https://www.coles.com.au/content/dam/coles/inspire-create/thumbnails/Tomato-and-bread-salad-480x288.jpg")
        .scaledToFit()
        .frame(width: 300)
}

