import defaultTheme from 'tailwindcss/defaultTheme';

/** @type {import('tailwindcss').Config} */
export default {

    theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: '#4A7055', // Xanh chủ đạo
          hover: '#3b5a44',   // Xanh khi hover
          light: '#4A705533', // Xanh nhạt (opacity 20%)
        },
        background: '#FAF9F5', // Màu nền tổng thể
      },
      fontFamily: {
        heading: ['"Playfair Display"', 'serif'],
        sans: ['"Inter"', 'sans-serif'],
      }
    },
  },
  plugins: [],

    content: [
        './vendor/laravel/framework/src/Illuminate/Pagination/resources/views/*.blade.php',
        './storage/framework/views/*.php',
        './resources/views/**/*.blade.php',
        './resources/js/**/*.vue', // Đảm bảo dòng này có mặt để Tailwind quét file Vue
    ],
    theme: {
        extend: {
            colors: {
                'brand-green': '#4A7055',
                'brand-green-dark': '#3a5944',
            },
        },
    },
    plugins: [],
};