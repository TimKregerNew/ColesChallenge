# Coles Recipe App

iOS recipe application built with SwiftUI for the Coles Mobile Coding Challenge. Features adaptive layouts that switch between detail view (portrait) and grid view (landscape) orientations.

## Features

- Adaptive layout based on device orientation
- Recipe details with ingredients, cooking times, and servings
- "More Recipes" discovery section
- Image caching and async loading
- Supports both local JSON and optional GraphQL data sources
- Automatic fallback to local data if GraphQL server is unavailable

## Requirements

- iOS 17.0+
- Xcode 16.0+
- Node.js 18+ (optional, for GraphQL server)

## Getting Started

### Running the App

1. Open `Coles.xcodeproj` in Xcode
2. Select a simulator or device
3. Press `Cmd + R` to build and run
4. Rotate device to see different layouts

The app works immediately with bundled local data.

### Optional: Running with GraphQL Server

If you want to test with the GraphQL server:

1. Start the server:
   ```bash
   ./start-server.sh
   ```

2. The server starts on `http://localhost:4000`

3. Run the iOS app - it will fetch from GraphQL

4. **GraphQL Playground** available at `http://localhost:4000` for testing queries

**Note:** The app automatically falls back to local JSON if the GraphQL server is offline, so it works seamlessly either way.

## Testing

Run unit tests:
```bash
xcodebuild test \
  -project Coles.xcodeproj \
  -scheme Coles \
  -destination 'platform=iOS Simulator,name=iPhone 16'
```

Or use the GitHub Actions workflow which runs automatically on push.

**Note:** Public GitHub runners can be slow and may occasionally timeout. Local testing is recommended for faster feedback.

## Technologies

- SwiftUI
- Swift Concurrency (async/await)
- Apollo iOS (GraphQL client)
- Node.js + Apollo Server (optional GraphQL backend)

## Known Issues

1. **Orientation Detection**: Layout doesn't respond to portrait upside-down orientation
2. **Accessibility**: Minimal accessibility support implemented (basic labels only)
3. **Typography**: Font styling may differ slightly from the design specification

---

**Author:** Tim Kreger  
**Challenge:** Coles Mobile Coding Challenge

