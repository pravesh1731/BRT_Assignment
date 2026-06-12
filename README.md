# Product Store - Flutter E-Commerce App

A modern Flutter e-commerce application built using **GetX**, **Dio**, and **SharedPreferences**. The app fetches products from a REST API, supports category filtering, wishlist management, product details, and infinite scrolling pagination.

---

##  Features

### Product Listing

* Fetch products from API
* Display product image, title, and price
* Responsive Grid Layout
* Cached product images

### Search

* Search products by title
* Real-time filtering

### Category Filter

* Filter products by category
* Dynamic category generation from API data
* "All Categories" option

### Product Details

* Detailed product information
* Product image
* Description
* Rating
* Price

### Wishlist

* Add/Remove products from wishlist
* Persist wishlist using SharedPreferences
* Favorite state maintained across app restarts

### Pagination

* Infinite scrolling
* Load products dynamically as user scrolls
* Optimized API requests


---

## Tech Stack

### Framework

* Flutter

### State Management

* GetX

### API Client

* Dio

### Local Storage

* SharedPreferences

### Image Caching

* Cached Network Image

---

## 📂 Project Structure

```text
lib/
│
├── controllers/
│   └── product_controller.dart
│
├── models/
│   └── product_model.dart
│
├── services/
│   └── api_service.dart
│
├── screens/
│   ├── home_screen.dart
│   └── product_detail_screen.dart
│
├── widgets/
│   └── product_card.dart
│
├── utils/
│   └── wishlist_service.dart
│
└── main.dart
```

---

## 🔌 API Used

DummyJSON Products API

```url
https://dummyjson.com/products
```

### Pagination Example

```url
https://dummyjson.com/products?limit=10&skip=0
```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter

  get: ^4.6.6
  dio: ^5.4.0
  cached_network_image: ^3.3.1
  shared_preferences: ^2.2.2
```

---

## ⚙️ Installation

### 1. Clone Repository

```bash
git clone <repository-url>
```

### 2. Navigate to Project

```bash
cd product-store
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run Application

```bash
flutter run
```

---

## 🧠 State Management Flow

```text
API Service
     ↓
Product Controller (GetX)
     ↓
Observable State
     ↓
UI Updates Automatically
```


## 📱 Screens

### Home Screen

* Product Grid
* Search Bar
* Category Filter
* Infinite Scroll

### Product Details Screen

* Product Image
* Product Information
* Rating
* Price
* Hero Animation
* 

# Part 2: DSA Questions

## Q1: Two Sum

### Brute Force Approach (O(n²))

```javascript
function twoSum(nums, target) {
  for (let i = 0; i < nums.length; i++) {
    for (let j = i + 1; j < nums.length; j++) {
      if (nums[i] + nums[j] === target) {
        return [i, j];
      }
    }
  }
}
```


### Optimized Approach (O(n))

```javascript
function twoSum(nums, target) {
  const map = {};

  for (let i = 0; i < nums.length; i++) {
    const complement = target - nums[i];

    if (map.hasOwnProperty(complement)) {
      return [map[complement], i];
    }

    map[nums[i]] = i;
  }

  return [];
}

// Example
console.log(twoSum([2, 7, 11, 15], 9));
// Output: [0, 1]
```


## Q2: Longest Substring Without Repeating Characters

### Optimized Approach (Sliding Window - O(n))


```javascript
function lengthOfLongestSubstring(s) {
  const map = new Map();

  let left = 0;
  let maxLength = 0;

  for (let right = 0; right < s.length; right++) {
    if (
      map.has(s[right]) &&
      map.get(s[right]) >= left
    ) {
      left = map.get(s[right]) + 1;
    }

    map.set(s[right], right);

    maxLength = Math.max(
      maxLength,
      right - left + 1
    );
  }

  return maxLength;
}

// Example
console.log(lengthOfLongestSubstring("abcabcbb"));
// Output: 3


