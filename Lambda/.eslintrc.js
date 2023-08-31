module.exports = {
  root: true,
  parser: '@typescript-eslint/parser',
  parserOptions: {
    project: './tsconfig.json',
    tsconfigRootDir: __dirname,
  },
  extends: ['@essensys/eslint-config-services'],
  // aws is installed on CI we should not apply linting to it
  ignorePatterns: ['node_modules', 'aws'],
}
