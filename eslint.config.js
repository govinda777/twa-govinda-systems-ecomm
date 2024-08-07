module.exports = {
  env: {
    browser: true,
    es2021: true,
  },
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaVersion: 12,
    sourceType: 'module',
  },
  plugins: [
    '@typescript-eslint',
  ],
  rules: {
    // Ajuste as regras conforme necessário
    'react/react-in-jsx-scope': 'off', // Exemplo: Desativa a regra de React em escopo
    '@typescript-eslint/no-unused-vars': 'warn', // Exemplo: Transforma erro em aviso
    '@typescript-eslint/no-explicit-any': 'off', // Exemplo: Desativa a regra de uso de 'any'
  },
};
