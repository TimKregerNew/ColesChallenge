#!/bin/bash

# Start the GraphQL server
cd "$(dirname "$0")/graphql-server"

echo "Starting GraphQL server..."
echo "Server will be available at http://localhost:4000"
echo "GraphQL Playground at http://localhost:4000"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

npm install
npm start

