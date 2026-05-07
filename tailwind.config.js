/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./resources/**/*.blade.php",
    "./resources/**/*.js",
    "./resources/**/*.ts",
    "./resources/**/*.vue",
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: '#4A7055',
          10: 'rgba(74, 112, 85, 0.1)',
        },
        background: {
          DEFAULT: '#FAF9F5',
        }
      },
      fontFamily: {
        sans: ['"Inter"', 'sans-serif'],
        serif: ['"Lora"', 'serif'],
      }
    },
  },
  plugins: [],
}