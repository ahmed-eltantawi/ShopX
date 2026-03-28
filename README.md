<p align="center">
  <img src="assets/app_logo.png" width="300" alt="App Logo" />
</p>

# The Archive (new_shopx)

A beautiful, luxury minimalist Flutter application focused on product management and seamless aesthetic experiences. "The Archive" features a stark contrast design language, balancing premium dark and light modes with refined typography and smooth interactions.

## 📱 Demo Video


https://github.com/user-attachments/assets/3070fd69-dd56-438c-b448-9c76d050b3d5



### App Screenshots

| Home Page | Add Product 1 | Add Product 2 |
|:---:|:---:|:---:|
| <img src="assets/home_page_dark.png" width="250" alt="Home Dark"> | <img src="assets/add_product_1_dark.png" width="250" alt="Add Product 1 Dark"> | <img src="assets/add_product_2_dark.png.png" width="250" alt="Add Product 2 Dark"> |
| <img src="assets/home_page_light.png" width="250" alt="Home Light"> | <img src="assets/add_product_1_light.png" width="250" alt="Add Product 1 Light"> | <img src="assets/add_product_2_light.png" width="250" alt="Add Product 2 Light"> |

## ✨ Features
- **Luxury Minimalist UI**: Designed with a "Stark Contrast" color palette emphasizing clean lines, bold typography (Jost font), and negative space.
- **Dynamic Theme Management**: A fully custom theme toggle drawer that smoothly transitions the app between its light and dark states.
- **Product Management**: Robust interfaces for adding, editing, and managing products efficiently.
- **Local Image Uploads**: Integrated image picking functionality using `image_picker` for seamless product photo uploads.
- **Pull-to-Refresh**: Intuitive pull-to-refresh interactions ensuring the product feed is always up-to-date.
- **Category Selection**: Streamlined dropdown menus to categorize and organize inventory.

## 🧠 What I Learned
Building "The Archive" provided valuable experience in advanced Flutter concepts, particularly focusing on UI/UX and state management:

1. **Crafting Premium UI/UX**: Moving beyond standard Material widgets to build custom, high-end interfaces. Learning how to effectively leverage negative space, custom fonts, and minimalist styling to create a luxury brand feel.
2. **Advanced Theming**: Implementing a custom `ThemeProvider` with `ValueNotifier` to handle seamless dynamic theme switching without relying on complex external state management libraries for simple tasks.
3. **Refining Micro-Interactions**: Improving the user experience by perfecting drawer toggle behaviors, optimizing input field spacing, and balancing visual hierarchy.
4. **Handling Device Storage & APIs**: Managing local image uploads through `image_picker` and coordinating UI responses (like pull-to-refresh) to mimic reliable API data synchronization.

## 📂 Project Structure (`lib/`)
```text
lib/
├── core/                           # Theming, constants, styles, and utilities
│   ├── app_colors.dart
│   ├── app_styles.dart
│   ├── consts.dart
│   ├── extenuations.dart
│   └── theme_provider.dart
├── models/                         # Data models
│   └── product_model.dart
├── screens/                        # UI screens
│   ├── home/
│   │   ├── home_screen.dart
│   │   └── widgets/
│   │       ├── art_of_everyday_section.dart
│   │       ├── hero_banner.dart
│   │       ├── product_card.dart
│   │       └── section_header.dart
│   └── update_product/
│       ├── update_product_screen.dart
│       └── widgets/
│           ├── archive_dropdown_field.dart
│           ├── archive_form_field.dart
│           └── product_image_preview.dart
├── services/                       # API/Network services
│   ├── add_product.dart
│   ├── api_class.dart
│   ├── get_all_products.dart
│   ├── get_categories.dart
│   ├── get_category_products.dart
│   └── update_product.dart
├── widgets/                        # Reusable UI components
│   ├── archive_app_bar.dart
│   ├── archive_bottom_nav_bar.dart
│   ├── archive_drawer.dart
│   ├── custom_button.dart
│   ├── custom_product_card.dart
│   ├── custom_text_field.dart
│   └── show_snack_bar.dart
└── main.dart                       # Application entry point
```

## 🛠️ Tech Stack
- **Framework**: [Flutter](https://flutter.dev/)
- **Language**: Dart
- **Key Packages**:
    - `image_picker` for image handling.
    - `http` for network requests.
    - `cupertino_icons` and custom fonts natively integrated.

## 🚀 Getting Started

To get a local copy up and running, follow these simple steps:

### Prerequisites
Make sure you have Flutter installed on your machine. You can find the installation guide [here](https://docs.flutter.dev/get-started/install).

### Installation
1. Clone the repo
   ```sh
   git clone https://github.com/your_username/new_shopx.git
   ```
2. Navigate to the project directory
   ```sh
   cd new_shopx
   ```
3. Install Flutter dependencies
   ```sh
   flutter pub get
   ```
4. Run the app
   ```sh
   flutter run
   ```

Feel free to fork the project and open a PR if you have any improvements!
