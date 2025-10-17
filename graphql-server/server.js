import { ApolloServer } from '@apollo/server';
import { startStandaloneServer } from '@apollo/server/standalone';
import { typeDefs } from './schema.js';
import { resolvers } from './resolvers.js';

// Create Apollo Server instance
const server = new ApolloServer({
  typeDefs,
  resolvers,
});

// Start the server
const { url } = await startStandaloneServer(server, {
  listen: { port: 4000 },
  context: async ({ req }) => ({
    // Add any context data here if needed
  }),
});

console.log(`🚀 GraphQL Server ready at: ${url}`);
console.log(`📝 Try these queries:`);
console.log(`   - recipes`);
console.log(`   - recipe(title: "...")`);
console.log(`   - searchRecipes(query: "...")`);
console.log(`   - randomRecipes(limit: 4)`);

