import globals from 'globals';
import { FlatCompat } from '@eslint/eslintrc';
const compat = new FlatCompat();
export default [
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
      '@typescript-eslint/no-unused-vars': ['warn', { varsIgnorePattern: '^_' }],
      '@typescript-eslint/no-explicit-any': 'off',
      '@typescript-eslint/no-require-imports': 'off',
    },
  },
  ...compat.extends('plugin:@typescript-eslint/recommended'),
];
