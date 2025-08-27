# API Integration Examples

This document provides real-world examples of how to integrate with the FoodTrip API, including complete workflows, error handling, and best practices.

## 🚀 Getting Started

### Base Configuration

```javascript
const API_BASE_URL = 'http://localhost:5000/api';

// HTTP client configuration (example with axios)
const apiClient = axios.create({
  baseURL: API_BASE_URL,
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json'
  }
});

// Token management
let authToken = null;

apiClient.interceptors.request.use(config => {
  if (authToken) {
    config.headers.Authorization = `Bearer ${authToken}`;
  }
  return config;
});
```

### Environment Variables

```javascript
// .env configuration
const config = {
  API_URL: process.env.API_URL || 'http://localhost:5000/api',
  API_TIMEOUT: process.env.API_TIMEOUT || 10000
};
```

## 🔐 Authentication Flows

### 1. User Login Flow

```javascript
/**
 * User authentication workflow
 */
class AuthService {
  async login(email, password) {
    try {
      const response = await apiClient.post('/home/login', {
        email,
        password
      });
      
      if (response.status === 200) {
        const { token, user } = response.data;
        
        // Store token for subsequent requests
        authToken = token;
        localStorage.setItem('auth_token', token);
        localStorage.setItem('user', JSON.stringify(user));
        
        return { success: true, user, token };
      }
    } catch (error) {
      return this.handleAuthError(error);
    }
  }
  
  async register(userData) {
    try {
      const response = await apiClient.post('/home/register', {
        name: userData.name,
        email: userData.email,
        password: userData.password,
        confirmPassword: userData.confirmPassword,
        phone: userData.phone
      });
      
      return { success: true, user: response.data.user };
    } catch (error) {
      return this.handleAuthError(error);
    }
  }
  
  handleAuthError(error) {
    if (error.response) {
      const { status, data } = error.response;
      
      switch (status) {
        case 400:
          return { success: false, error: 'Invalid input data', details: data.message };
        case 401:
          return { success: false, error: 'Invalid credentials' };
        case 409:
          return { success: false, error: 'Email already exists' };
        default:
          return { success: false, error: 'Authentication failed' };
      }
    }
    
    return { success: false, error: 'Network error' };
  }
  
  logout() {
    authToken = null;
    localStorage.removeItem('auth_token');
    localStorage.removeItem('user');
  }
  
  isAuthenticated() {
    return !!authToken || !!localStorage.getItem('auth_token');
  }
  
  getStoredToken() {
    if (!authToken) {
      authToken = localStorage.getItem('auth_token');
    }
    return authToken;
  }
}

// Usage example
const auth = new AuthService();

// Login
const loginResult = await auth.login('customer@foodtrip.com', 'password123');
if (loginResult.success) {
  console.log('Login successful:', loginResult.user);
} else {
  console.error('Login failed:', loginResult.error);
}

// Register
const registerResult = await auth.register({
  name: 'John Doe',
  email: 'john@example.com',
  password: 'password123',
  confirmPassword: 'password123',
  phone: '1234567890'
});
```

### 2. Token Refresh and Management

```javascript
/**
 * Token management with automatic refresh
 */
class TokenManager {
  constructor() {
    this.token = localStorage.getItem('auth_token');
    this.refreshToken = localStorage.getItem('refresh_token');
  }
  
  async refreshAuthToken() {
    try {
      const response = await apiClient.post('/auth/refresh', {
        refresh_token: this.refreshToken
      });
      
      const { token, refresh_token } = response.data;
      this.setTokens(token, refresh_token);
      
      return token;
    } catch (error) {
      this.clearTokens();
      throw new Error('Token refresh failed');
    }
  }
  
  setTokens(token, refreshToken) {
    this.token = token;
    this.refreshToken = refreshToken;
    authToken = token;
    
    localStorage.setItem('auth_token', token);
    localStorage.setItem('refresh_token', refreshToken);
  }
  
  clearTokens() {
    this.token = null;
    this.refreshToken = null;
    authToken = null;
    
    localStorage.removeItem('auth_token');
    localStorage.removeItem('refresh_token');
  }
}

// Automatic token refresh interceptor
apiClient.interceptors.response.use(
  response => response,
  async error => {
    if (error.response?.status === 401 && authToken) {
      try {
        const tokenManager = new TokenManager();
        await tokenManager.refreshAuthToken();
        
        // Retry original request
        return apiClient.request(error.config);
      } catch (refreshError) {
        // Redirect to login
        window.location.href = '/login';
      }
    }
    
    return Promise.reject(error);
  }
);
```

## 🏪 Restaurant Management Examples

### 1. Restaurant Admin Operations

```javascript
/**
 * Restaurant management service
 */
class RestaurantService {
  async createRestaurant(restaurantData) {
    try {
      const response = await apiClient.post('/resto_admin/restaurant', {
        name: restaurantData.name,
        description: restaurantData.description,
        address: restaurantData.address,
        phone: restaurantData.phone,
        opening_hour: restaurantData.openingHour,
        closing_hour: restaurantData.closingHour,
        restocategory_id: restaurantData.categoryId
      });
      
      return { success: true, restaurant: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async getRestaurant() {
    try {
      const response = await apiClient.get('/resto_admin/restaurant');
      return { success: true, restaurant: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async updateRestaurant(updateData) {
    try {
      const response = await apiClient.put('/resto_admin/restaurant', updateData);
      return { success: true, restaurant: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  // Dish management
  async createDish(dishData, imageFile = null) {
    try {
      const formData = new FormData();
      formData.append('name', dishData.name);
      formData.append('description', dishData.description);
      formData.append('price', dishData.price);
      formData.append('dishcategory_id', dishData.categoryId);
      
      if (imageFile) {
        formData.append('image', imageFile);
      }
      
      const response = await apiClient.post('/resto_admin/dish', formData, {
        headers: { 'Content-Type': 'multipart/form-data' }
      });
      
      return { success: true, dish: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async getDishes() {
    try {
      const response = await apiClient.get('/resto_admin/dishes');
      return { success: true, dishes: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async updateDish(dishId, updateData, imageFile = null) {
    try {
      const formData = new FormData();
      
      Object.keys(updateData).forEach(key => {
        formData.append(key, updateData[key]);
      });
      
      if (imageFile) {
        formData.append('image', imageFile);
      }
      
      const response = await apiClient.put(`/resto_admin/dish/${dishId}`, formData, {
        headers: { 'Content-Type': 'multipart/form-data' }
      });
      
      return { success: true, dish: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async deleteDish(dishId) {
    try {
      await apiClient.delete(`/resto_admin/dish/${dishId}`);
      return { success: true, message: 'Dish deleted successfully' };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  handleError(error) {
    if (error.response) {
      const { status, data } = error.response;
      
      switch (status) {
        case 400:
          return { success: false, error: 'Invalid data', details: data.message };
        case 401:
          return { success: false, error: 'Unauthorized access' };
        case 403:
          return { success: false, error: 'Insufficient permissions' };
        case 404:
          return { success: false, error: 'Resource not found' };
        default:
          return { success: false, error: 'Server error' };
      }
    }
    
    return { success: false, error: 'Network error' };
  }
}

// Usage examples
const restaurantService = new RestaurantService();

// Create restaurant
const restaurantData = {
  name: 'Delicious Diner',
  description: 'Best food in town',
  address: '123 Main Street',
  phone: '555-0123',
  openingHour: '08:00',
  closingHour: '22:00',
  categoryId: 1
};

const result = await restaurantService.createRestaurant(restaurantData);
if (result.success) {
  console.log('Restaurant created:', result.restaurant);
}

// Create dish with image
const dishData = {
  name: 'Spicy Noodles',
  description: 'Delicious spicy noodles',
  price: 25000,
  categoryId: 1
};

const imageFile = document.getElementById('dish-image').files[0];
const dishResult = await restaurantService.createDish(dishData, imageFile);
```

### 2. Opening Hours Management

```javascript
/**
 * Opening hours management
 */
class OpeningHoursService {
  async createOpeningHour(dayData) {
    try {
      const response = await apiClient.post('/resto_admin/opening-hour', {
        day: dayData.day,
        opening_time: dayData.openingTime,
        closing_time: dayData.closingTime,
        is_open: dayData.isOpen
      });
      
      return { success: true, openingHour: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async getOpeningHours() {
    try {
      const response = await apiClient.get('/resto_admin/opening-hours');
      return { success: true, openingHours: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async updateOpeningHour(id, updateData) {
    try {
      const response = await apiClient.put(`/resto_admin/opening-hour/${id}`, updateData);
      return { success: true, openingHour: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async deleteOpeningHour(id) {
    try {
      await apiClient.delete(`/resto_admin/opening-hour/${id}`);
      return { success: true, message: 'Opening hour deleted' };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  handleError(error) {
    // Similar error handling as RestaurantService
    return { success: false, error: 'Operation failed' };
  }
}

// Usage: Setup weekly schedule
const openingHours = new OpeningHoursService();

const weeklySchedule = [
  { day: 'monday', openingTime: '08:00', closingTime: '22:00', isOpen: true },
  { day: 'tuesday', openingTime: '08:00', closingTime: '22:00', isOpen: true },
  { day: 'wednesday', openingTime: '08:00', closingTime: '22:00', isOpen: true },
  { day: 'thursday', openingTime: '08:00', closingTime: '22:00', isOpen: true },
  { day: 'friday', openingTime: '08:00', closingTime: '23:00', isOpen: true },
  { day: 'saturday', openingTime: '09:00', closingTime: '23:00', isOpen: true },
  { day: 'sunday', openingTime: '09:00', closingTime: '21:00', isOpen: true }
];

for (const schedule of weeklySchedule) {
  await openingHours.createOpeningHour(schedule);
}
```

## 🛒 Customer Order Flow Examples

### 1. Complete Order Workflow

```javascript
/**
 * Customer order management
 */
class OrderService {
  async addToCart(dishId, quantity, notes = '') {
    try {
      const response = await apiClient.post('/customer/cart', {
        dish_id: dishId,
        quantity: quantity,
        notes: notes
      });
      
      return { success: true, cartItem: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async getCart() {
    try {
      const response = await apiClient.get('/customer/cart');
      return { success: true, cart: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async updateCartItem(cartId, quantity, notes = '') {
    try {
      const response = await apiClient.put(`/customer/cart/${cartId}`, {
        quantity: quantity,
        notes: notes
      });
      
      return { success: true, cartItem: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async removeFromCart(cartId) {
    try {
      await apiClient.delete(`/customer/cart/${cartId}`);
      return { success: true, message: 'Item removed from cart' };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async createOrder(orderData) {
    try {
      const response = await apiClient.post('/customer/order', {
        address_id: orderData.addressId,
        payment_method: orderData.paymentMethod,
        notes: orderData.notes || ''
      });
      
      return { success: true, order: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async getOrders() {
    try {
      const response = await apiClient.get('/customer/orders');
      return { success: true, orders: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async getOrderDetails(orderId) {
    try {
      const response = await apiClient.get(`/customer/order/${orderId}`);
      return { success: true, order: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  handleError(error) {
    if (error.response) {
      const { status, data } = error.response;
      
      switch (status) {
        case 400:
          return { success: false, error: 'Invalid order data', details: data.message };
        case 404:
          return { success: false, error: 'Item not found' };
        case 409:
          return { success: false, error: 'Cart conflict', details: data.message };
        default:
          return { success: false, error: 'Order operation failed' };
      }
    }
    
    return { success: false, error: 'Network error' };
  }
}

// Complete order flow example
async function completeOrderFlow() {
  const orderService = new OrderService();
  
  try {
    // 1. Add items to cart
    console.log('Adding items to cart...');
    await orderService.addToCart(1, 2, 'Extra spicy');
    await orderService.addToCart(3, 1, 'No onions');
    
    // 2. Review cart
    console.log('Reviewing cart...');
    const cartResult = await orderService.getCart();
    if (cartResult.success) {
      console.log('Cart contents:', cartResult.cart);
      
      // Calculate total
      const total = cartResult.cart.reduce((sum, item) => 
        sum + (item.dish.price * item.quantity), 0
      );
      console.log('Total amount:', total);
    }
    
    // 3. Update cart item if needed
    const firstCartItem = cartResult.cart[0];
    if (firstCartItem) {
      console.log('Updating cart item...');
      await orderService.updateCartItem(firstCartItem.id, 3, 'Make it extra extra spicy');
    }
    
    // 4. Create order
    console.log('Creating order...');
    const orderResult = await orderService.createOrder({
      addressId: 1,
      paymentMethod: 'cash',
      notes: 'Please call when arrived'
    });
    
    if (orderResult.success) {
      console.log('Order created successfully:', orderResult.order);
      
      // 5. Get order details
      const orderDetails = await orderService.getOrderDetails(orderResult.order.id);
      console.log('Order details:', orderDetails.order);
    }
    
  } catch (error) {
    console.error('Order flow failed:', error);
  }
}
```

### 2. Address Management

```javascript
/**
 * Customer address management
 */
class AddressService {
  async createAddress(addressData) {
    try {
      const response = await apiClient.post('/customer/address', {
        title: addressData.title,
        address: addressData.address,
        latitude: addressData.latitude,
        longitude: addressData.longitude,
        is_primary: addressData.isPrimary || false
      });
      
      return { success: true, address: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async getAddresses() {
    try {
      const response = await apiClient.get('/customer/addresses');
      return { success: true, addresses: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async updateAddress(addressId, updateData) {
    try {
      const response = await apiClient.put(`/customer/address/${addressId}`, updateData);
      return { success: true, address: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async deleteAddress(addressId) {
    try {
      await apiClient.delete(`/customer/address/${addressId}`);
      return { success: true, message: 'Address deleted' };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async setPrimaryAddress(addressId) {
    try {
      const response = await apiClient.put(`/customer/address/${addressId}/primary`);
      return { success: true, address: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  handleError(error) {
    // Similar error handling
    return { success: false, error: 'Address operation failed' };
  }
}

// Usage example
const addressService = new AddressService();

// Create address with geolocation
const newAddress = {
  title: 'Home',
  address: '123 Main Street, City, State 12345',
  latitude: 40.7128,
  longitude: -74.0060,
  isPrimary: true
};

const addressResult = await addressService.createAddress(newAddress);
```

## 🔍 Public API Examples

### 1. Restaurant and Dish Discovery

```javascript
/**
 * Public API for browsing restaurants and dishes
 */
class PublicApiService {
  async getRestaurants(filters = {}) {
    try {
      const params = new URLSearchParams();
      
      if (filters.category) params.append('category', filters.category);
      if (filters.search) params.append('search', filters.search);
      if (filters.limit) params.append('limit', filters.limit);
      if (filters.offset) params.append('offset', filters.offset);
      
      const url = params.toString() ? `/home/restaurants?${params}` : '/home/restaurants';
      const response = await apiClient.get(url);
      
      return { success: true, restaurants: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async getRestaurantDetails(restaurantId) {
    try {
      const response = await apiClient.get(`/home/restaurant/${restaurantId}`);
      return { success: true, restaurant: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async getDishes(filters = {}) {
    try {
      const params = new URLSearchParams();
      
      if (filters.restaurant_id) params.append('restaurant_id', filters.restaurant_id);
      if (filters.category_id) params.append('category_id', filters.category_id);
      if (filters.search) params.append('search', filters.search);
      if (filters.min_price) params.append('min_price', filters.min_price);
      if (filters.max_price) params.append('max_price', filters.max_price);
      
      const url = params.toString() ? `/home/dishes?${params}` : '/home/dishes';
      const response = await apiClient.get(url);
      
      return { success: true, dishes: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async getDishCategories() {
    try {
      const response = await apiClient.get('/home/dish-categories');
      return { success: true, categories: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  async getRestaurantCategories() {
    try {
      const response = await apiClient.get('/home/restaurant-categories');
      return { success: true, categories: response.data };
    } catch (error) {
      return this.handleError(error);
    }
  }
  
  handleError(error) {
    return { success: false, error: 'Failed to fetch data' };
  }
}

// Usage examples
const publicApi = new PublicApiService();

// Get restaurants with filters
const restaurantFilters = {
  category: 'italian',
  search: 'pizza',
  limit: 10,
  offset: 0
};

const restaurantsResult = await publicApi.getRestaurants(restaurantFilters);

// Get dishes from specific restaurant
const dishFilters = {
  restaurant_id: 1,
  category_id: 2,
  min_price: 10000,
  max_price: 50000
};

const dishesResult = await publicApi.getDishes(dishFilters);
```

## 🔧 Error Handling Best Practices

### 1. Comprehensive Error Handler

```javascript
/**
 * Centralized error handling utility
 */
class ApiErrorHandler {
  static handle(error, context = '') {
    if (!error.response) {
      // Network error
      return {
        type: 'network',
        message: 'Network connection failed',
        userMessage: 'Please check your internet connection and try again.',
        context
      };
    }
    
    const { status, data } = error.response;
    
    switch (status) {
      case 400:
        return {
          type: 'validation',
          message: data.message || 'Invalid request data',
          userMessage: 'Please check your input and try again.',
          details: data.errors || [],
          context
        };
        
      case 401:
        return {
          type: 'authentication',
          message: 'Authentication required',
          userMessage: 'Please log in to continue.',
          context
        };
        
      case 403:
        return {
          type: 'authorization',
          message: 'Insufficient permissions',
          userMessage: 'You do not have permission to perform this action.',
          context
        };
        
      case 404:
        return {
          type: 'not_found',
          message: data.message || 'Resource not found',
          userMessage: 'The requested item could not be found.',
          context
        };
        
      case 409:
        return {
          type: 'conflict',
          message: data.message || 'Data conflict',
          userMessage: 'This action conflicts with existing data.',
          details: data.details || '',
          context
        };
        
      case 422:
        return {
          type: 'unprocessable',
          message: data.message || 'Validation failed',
          userMessage: 'Please check your input data.',
          details: data.errors || [],
          context
        };
        
      case 429:
        return {
          type: 'rate_limit',
          message: 'Too many requests',
          userMessage: 'Please wait a moment before trying again.',
          context
        };
        
      case 500:
        return {
          type: 'server',
          message: 'Internal server error',
          userMessage: 'Something went wrong on our end. Please try again later.',
          context
        };
        
      default:
        return {
          type: 'unknown',
          message: data.message || 'Unknown error occurred',
          userMessage: 'An unexpected error occurred. Please try again.',
          context
        };
    }
  }
  
  static showUserMessage(error, notificationService) {
    const errorInfo = this.handle(error);
    
    switch (errorInfo.type) {
      case 'network':
        notificationService.error(errorInfo.userMessage);
        break;
        
      case 'authentication':
        notificationService.error(errorInfo.userMessage);
        // Redirect to login
        break;
        
      case 'validation':
        notificationService.warning(errorInfo.userMessage);
        // Show field-specific errors
        break;
        
      default:
        notificationService.error(errorInfo.userMessage);
    }
  }
}

// Usage in services
class EnhancedRestaurantService {
  async createRestaurant(data) {
    try {
      const response = await apiClient.post('/resto_admin/restaurant', data);
      return { success: true, data: response.data };
    } catch (error) {
      const errorInfo = ApiErrorHandler.handle(error, 'create_restaurant');
      console.error('Restaurant creation failed:', errorInfo);
      
      return {
        success: false,
        error: errorInfo.message,
        userMessage: errorInfo.userMessage,
        type: errorInfo.type,
        details: errorInfo.details
      };
    }
  }
}
```

### 2. Retry Logic

```javascript
/**
 * Request retry utility with exponential backoff
 */
class RetryHandler {
  static async withRetry(requestFn, options = {}) {
    const {
      maxRetries = 3,
      initialDelay = 1000,
      maxDelay = 10000,
      backoffFactor = 2,
      retryCondition = (error) => error.response?.status >= 500
    } = options;
    
    let lastError;
    
    for (let attempt = 0; attempt <= maxRetries; attempt++) {
      try {
        return await requestFn();
      } catch (error) {
        lastError = error;
        
        if (attempt === maxRetries || !retryCondition(error)) {
          throw error;
        }
        
        const delay = Math.min(
          initialDelay * Math.pow(backoffFactor, attempt),
          maxDelay
        );
        
        console.log(`Request failed, retrying in ${delay}ms... (attempt ${attempt + 1}/${maxRetries})`);
        await new Promise(resolve => setTimeout(resolve, delay));
      }
    }
    
    throw lastError;
  }
}

// Usage with retry
const createRestaurantWithRetry = async (data) => {
  return RetryHandler.withRetry(
    () => apiClient.post('/resto_admin/restaurant', data),
    {
      maxRetries: 3,
      retryCondition: (error) => error.response?.status >= 500
    }
  );
};
```

## 📱 Frontend Integration Examples

### 1. React Integration

```jsx
// React hooks for API integration
import { useState, useEffect, useCallback } from 'react';

const useApi = (apiCall, dependencies = []) => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  
  const execute = useCallback(async (...args) => {
    setLoading(true);
    setError(null);
    
    try {
      const result = await apiCall(...args);
      if (result.success) {
        setData(result.data || result);
        return result;
      } else {
        setError(result.error);
        return result;
      }
    } catch (err) {
      const errorInfo = ApiErrorHandler.handle(err);
      setError(errorInfo.userMessage);
      return { success: false, error: errorInfo };
    } finally {
      setLoading(false);
    }
  }, dependencies);
  
  return { data, loading, error, execute };
};

// Restaurant list component
const RestaurantList = () => {
  const publicApi = new PublicApiService();
  const { data: restaurants, loading, error, execute } = useApi(
    (filters) => publicApi.getRestaurants(filters)
  );
  
  useEffect(() => {
    execute();
  }, []);
  
  if (loading) return <div>Loading restaurants...</div>;
  if (error) return <div>Error: {error}</div>;
  
  return (
    <div>
      {restaurants?.map(restaurant => (
        <div key={restaurant.id}>
          <h3>{restaurant.name}</h3>
          <p>{restaurant.description}</p>
          <p>{restaurant.address}</p>
        </div>
      ))}
    </div>
  );
};
```

### 2. Vue.js Integration

```javascript
// Vue composition API
import { ref, computed, onMounted } from 'vue';

export function useRestaurants() {
  const restaurants = ref([]);
  const loading = ref(false);
  const error = ref(null);
  
  const publicApi = new PublicApiService();
  
  const fetchRestaurants = async (filters = {}) => {
    loading.value = true;
    error.value = null;
    
    try {
      const result = await publicApi.getRestaurants(filters);
      if (result.success) {
        restaurants.value = result.restaurants;
      } else {
        error.value = result.error;
      }
    } catch (err) {
      error.value = 'Failed to fetch restaurants';
    } finally {
      loading.value = false;
    }
  };
  
  const filteredRestaurants = computed(() => {
    return restaurants.value.filter(restaurant => restaurant.is_active);
  });
  
  onMounted(() => {
    fetchRestaurants();
  });
  
  return {
    restaurants: filteredRestaurants,
    loading,
    error,
    fetchRestaurants
  };
}
```

## 🔒 Security Best Practices

### 1. Secure Token Storage

```javascript
/**
 * Secure token storage utility
 */
class SecureStorage {
  static setToken(token) {
    // Use secure storage methods
    if (this.isSecureContext()) {
      // Use secure cookie with httpOnly flag
      document.cookie = `auth_token=${token}; Secure; HttpOnly; SameSite=Strict`;
    } else {
      // Fallback to sessionStorage for development
      sessionStorage.setItem('auth_token', token);
    }
  }
  
  static getToken() {
    if (this.isSecureContext()) {
      return this.getCookieValue('auth_token');
    } else {
      return sessionStorage.getItem('auth_token');
    }
  }
  
  static removeToken() {
    if (this.isSecureContext()) {
      document.cookie = 'auth_token=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;';
    } else {
      sessionStorage.removeItem('auth_token');
    }
  }
  
  static isSecureContext() {
    return window.isSecureContext && location.protocol === 'https:';
  }
  
  static getCookieValue(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) return parts.pop().split(';').shift();
  }
}
```

### 2. Input Validation

```javascript
/**
 * Input validation utilities
 */
class ValidationUtils {
  static validateEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  }
  
  static validatePassword(password) {
    return password && password.length >= 8;
  }
  
  static validatePhone(phone) {
    const phoneRegex = /^\d{10,15}$/;
    return phoneRegex.test(phone.replace(/\D/g, ''));
  }
  
  static sanitizeInput(input) {
    if (typeof input !== 'string') return input;
    
    return input
      .trim()
      .replace(/[<>]/g, '') // Basic XSS prevention
      .substring(0, 1000); // Length limit
  }
  
  static validateRestaurantData(data) {
    const errors = [];
    
    if (!data.name || data.name.length < 2) {
      errors.push('Restaurant name must be at least 2 characters');
    }
    
    if (!data.address || data.address.length < 10) {
      errors.push('Address must be at least 10 characters');
    }
    
    if (!data.phone || !this.validatePhone(data.phone)) {
      errors.push('Valid phone number is required');
    }
    
    return {
      isValid: errors.length === 0,
      errors
    };
  }
}

// Usage in forms
const handleSubmit = async (formData) => {
  // Validate input
  const validation = ValidationUtils.validateRestaurantData(formData);
  if (!validation.isValid) {
    console.error('Validation errors:', validation.errors);
    return;
  }
  
  // Sanitize input
  const sanitizedData = {
    name: ValidationUtils.sanitizeInput(formData.name),
    description: ValidationUtils.sanitizeInput(formData.description),
    address: ValidationUtils.sanitizeInput(formData.address),
    phone: formData.phone
  };
  
  // Submit to API
  const result = await restaurantService.createRestaurant(sanitizedData);
};
```

## 📊 Performance Optimization

### 1. Request Caching

```javascript
/**
 * Simple in-memory cache for API responses
 */
class ApiCache {
  constructor(ttl = 300000) { // 5 minutes default TTL
    this.cache = new Map();
    this.ttl = ttl;
  }
  
  set(key, data) {
    const expiry = Date.now() + this.ttl;
    this.cache.set(key, { data, expiry });
  }
  
  get(key) {
    const cached = this.cache.get(key);
    
    if (!cached) return null;
    
    if (Date.now() > cached.expiry) {
      this.cache.delete(key);
      return null;
    }
    
    return cached.data;
  }
  
  clear() {
    this.cache.clear();
  }
  
  generateKey(url, params = {}) {
    const sortedParams = Object.keys(params)
      .sort()
      .map(key => `${key}=${params[key]}`)
      .join('&');
    
    return `${url}?${sortedParams}`;
  }
}

// Enhanced API service with caching
class CachedPublicApiService extends PublicApiService {
  constructor() {
    super();
    this.cache = new ApiCache(600000); // 10 minutes cache
  }
  
  async getRestaurants(filters = {}) {
    const cacheKey = this.cache.generateKey('/home/restaurants', filters);
    const cached = this.cache.get(cacheKey);
    
    if (cached) {
      return { success: true, restaurants: cached, fromCache: true };
    }
    
    const result = await super.getRestaurants(filters);
    
    if (result.success) {
      this.cache.set(cacheKey, result.restaurants);
    }
    
    return result;
  }
}
```

### 2. Request Debouncing

```javascript
/**
 * Debounced search functionality
 */
class DebouncedSearch {
  constructor(searchFn, delay = 300) {
    this.searchFn = searchFn;
    this.delay = delay;
    this.timeoutId = null;
  }
  
  search(query) {
    clearTimeout(this.timeoutId);
    
    this.timeoutId = setTimeout(() => {
      this.searchFn(query);
    }, this.delay);
  }
  
  cancel() {
    clearTimeout(this.timeoutId);
  }
}

// Usage in search component
const searchService = new DebouncedSearch(async (query) => {
  if (query.length >= 2) {
    const result = await publicApi.getRestaurants({ search: query });
    // Update UI with results
  }
}, 300);

// In input handler
const handleSearchInput = (event) => {
  const query = event.target.value;
  searchService.search(query);
};
```

This comprehensive API integration guide provides real-world examples for implementing FoodTrip API in frontend applications, with proper error handling, security measures, and performance optimizations. Use these patterns as templates for your integration work.
