## FITLIFE - Personalized Diet Recommendation App
## Project Overview
FIT-LIFE is a mobile application designed to offer personalized diet recommendations based on user input, such as age, weight, height, goals, and dietary preferences. The app aims to make tailored dietary advice more accessible by suggesting diets that best fit individual needs.

The project was developed with a focus on user-friendliness, security, and functionality. This README provides an overview of the app’s key features, setup instructions, and project structure to guide collaborators, users, and future contributors.

## Features
User Authentication: Secure login and registration using Firebase Authentication.
User Profile: Data input for personalized diet matching based on age, height, weight, goals, and preferences.
Personalized Diet Suggestions: Diet filtering algorithm suggests suitable plans based on user data.
Browse Diets: Users can browse all available diet plans and view detailed descriptions.
Guest Access: Users can explore general diet options without creating an account.
Settings: Account management options, including Sign Out and Delete Account.

## Technologies Used
Frontend: Developed in Flutter for a smooth, cross-platform mobile experience.
Backend: Firebase for database management and user authentication.
Design: UI and UX designed in Figma, including navigation flow, color palette, and layout.
Version Control: Git and GitHub for collaborative code management.

## Project Structure
The project is organized as follows:

/lib - Contains all Flutter code, including UI and logic.
/assets - Images and other media assets used in the app.
/data - JSON files and sample datasets for diets.
/firebase - Configuration files for Firebase integration.

## Prerequisites
Flutter installed on your machine (installation guide).
Firebase project with necessary configurations for Authentication and Firestore.

## Installation
Clone the repository with:
git clone https://github.com/username/FITLIFE.git

Install dependencies with:
flutter pub get

Set up Firebase for iOS and Android in the Firebase Console. Then place google-services.json (Android) and GoogleService-Info.plist (iOS) files in the respective directories. Run the app with:
flutter run

## Usage
Sign up or log in to access personalized diet suggestions. If not signed in, you can use the “Continue without an account” option for general browsing. Update profile information in the "My Account" section to receive tailored diet recommendations. Use “Sign Out” and “Delete Account” options in Settings for account management.

## Limitations
Dataset Size: Current diet dataset is limited and will be expanded in the future.
Non-Professional Review: Diet recommendations have not yet been reviewed by certified nutritionists and should be used for general guidance only.

## Future Improvements
Diet dataset should be expanded with more instances and detailed nutritional information.
Expert reviews should be incorporated for diet plans.

## Key Learnings
This project provided experience in:

Technical Skills: Developing cross-platform mobile apps with Flutter, using Firebase for backend functions, and collaborative version control with GitHub.
Professional Skills: Improved time management, communication with team members, and problem-solving in a real-world development environment.
Contributors
[Zeynep Özgür Gün] - Full-stack development, design, and project coordination.
[Şule Merve Atalay] - Initial project ideation and early development support.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
