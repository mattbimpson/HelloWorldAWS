process.env.TZ = 'UTC'

export default {
  preset: 'ts-jest',
  rootDir: '.',
  roots: ['<rootDir>'],
  modulePaths: ['<rootDir>'],
  testEnvironment: 'node',
  transformIgnorePatterns: ['/node_modules/'],
  testTimeout: 20000,
  collectCoverage: false,
  testPathIgnorePatterns: ['/node_modules/'],
  setupFiles: ['<rootDir>/jest.setup.js'],
}
