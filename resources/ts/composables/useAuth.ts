import { ref } from 'vue';
import axios from 'axios';

// Shared auth state (singleton pattern)
const user = ref<{ id: number; name: string; email: string } | null>(null);
const isLoggedIn = ref(false);
const authLoading = ref(true);

async function fetchUser() {
    try {
        // Gọi /api/user để kiểm tra session hiện tại
        const response = await axios.get('/api/user', {
            withCredentials: true,
        });
        user.value = response.data;
        isLoggedIn.value = true;
    } catch {
        user.value = null;
        isLoggedIn.value = false;
    } finally {
        authLoading.value = false;
    }
}

async function logout() {
    try {
        await axios.post('/logout');
    } finally {
        user.value = null;
        isLoggedIn.value = false;
    }
}

export function useAuth() {
    return { user, isLoggedIn, authLoading, fetchUser, logout };
}
