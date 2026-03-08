import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import vue from '@vitejs/plugin-vue';
import tailwindcss from '@tailwindcss/vite'; // 1. Thêm import Tailwind v4

export default defineConfig({
    plugins: [
        tailwindcss(), // 2. Gọi plugin Tailwind ở đây
        laravel({
            input: ['resources/ts/main.ts'],
            refresh: true,
        }),
        vue({
            template: {
                transformAssetUrls: {
                    base: null,
                    includeAbsolute: false,
                },
            },
        }),
    ],
    resolve: {
        alias: {
            '@': '/resources/ts',
        }
    }
});