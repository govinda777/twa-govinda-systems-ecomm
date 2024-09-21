module.exports = {
  parser: '@typescript-eslint/parser',
  parserOptions: {
    project: './tsconfig.json',
    sourceType: 'module',
    ecmaVersion: 2021,
  },
  
  env: {
    browser: true,
    es2021: true,
    node: true,
  },
  
  extends: [
    'eslint:recommended',
    'plugin:react/recommended',
    'plugin:@typescript-eslint/recommended',
  ],
  
  settings: {
    react: {
      version: 'detect',
    },
  },
  
  rules: {
    'react/prop-types': 'off',
    '@typescript-eslint/no-unused-vars': ['error'],
    '@typescript-eslint/explicit-function-return-type': 'off',
    '@typescript-eslint/no-explicit-any': 'warn',
    'no-console': 'warn',
  },
  
  plugins: ['react', '@typescript-eslint'],
};
