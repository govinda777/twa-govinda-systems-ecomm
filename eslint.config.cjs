const globals = require('globals');
const { FlatCompat } = require('@eslint/eslintrc');

const compat = new FlatCompat();

module.exports = [
  {
    ignores: ['node_modules/**'],
  },
  {
    languageOptions: {
      ecmaVersion: 2021,
      sourceType: 'module',
      globals: {
        ...globals.browser,
        ...globals.es2021,
      },
    },
    rules: {
      'react/react-in-jsx-scope': 'off',
      '@typescript-eslint/no-unused-vars': ['warn', { argsIgnorePattern: '^_' }],
      '@typescript-eslint/no-explicit-any': 'off',
      '@typescript-eslint/no-require-imports': 'off',
    },
  },
  ...compat.extends('plugin:@typescript-eslint/recommended'),
];
