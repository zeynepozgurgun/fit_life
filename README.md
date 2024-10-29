## FITLIFE - Personalized Diet Recommendation App
## Project Overview
FIT-LIFE is a mobile application designed to offer personalized diet recommendations based on user input, such as age, weight, height, goals, and dietary preferences. The app aims to make tailored dietary advice more accessible by suggesting diets that best fit individual needs. <br/>
<br/>
The project was developed with a focus on user-friendliness, security, and functionality. This README provides an overview of the app’s key features, setup instructions, and project structure to guide collaborators, users, and future contributors. <br/>

## Features
User Authentication: Secure login and registration using Firebase Authentication. <br/>
User Profile: Data input for personalized diet matching based on age, height, weight, goals, and preferences. <br/>
Personalized Diet Suggestions: Diet filtering algorithm suggests suitable plans based on user data. <br/>
Browse Diets: Users can browse all available diet plans and view detailed descriptions. <br/>
Guest Access: Users can explore general diet options without creating an account. <br/>
Settings: Account management options, including Sign Out and Delete Account. <br/>

## Technologies Used
Frontend: Developed in Flutter for a smooth, cross-platform mobile experience. <br/>
Backend: Firebase for database management and user authentication. <br/>
Design: UI and UX designed in Figma, including navigation flow, color palette, and layout. <br/>
Version Control: Git and GitHub for collaborative code management. <br/>

## Project Structure
The project is organized as follows: <br/>
<br/>
/lib - Contains all Flutter code, including UI and logic. <br/>
/assets - Images and other media assets used in the app. <br/>
/data - JSON files and sample datasets for diets. <br/>
/firebase - Configuration files for Firebase integration. <br/>

## Prerequisites
- Flutter installed on your machine (installation guide).
- Firebase project with necessary configurations for Authentication and Firestore.

## Installation
Clone the repository with: <br/>
git clone https://github.com/username/FITLIFE.git <br/>
<br/>
Install dependencies with:<br/>
flutter pub get <br/>
<br/>
Set up Firebase for iOS and Android in the Firebase Console. Then place google-services.json (Android) and GoogleService-Info.plist (iOS) files in the respective directories. Run the app with: <br/>
flutter run<br/>

## Usage
Sign up or log in to access personalized diet suggestions. If not signed in, you can use the “Continue without an account” option for general browsing. Update profile information in the "My Account" section to receive tailored diet recommendations. Use “Sign Out” and “Delete Account” options in Settings for account management.

## Limitations
- Dataset Size: Current diet dataset is limited and will be expanded in the future.
- Non-Professional Review: Diet recommendations have not yet been reviewed by certified nutritionists and should be used for general guidance only.

## Future Improvements
- Diet dataset should be expanded with more instances and detailed nutritional information.
- Expert reviews should be incorporated for diet plans.

## Key Learnings
This project provided experience in:<br/>

Technical Skills: Developing cross-platform mobile apps with Flutter, using Firebase for backend functions, and collaborative version control with GitHub. <br/>
Professional Skills: Improved time management, communication with team members, and problem-solving in a real-world development environment. 

## Contributors
[Zeynep Özgür Gün] - Full-stack development, design, and project coordination.<br/>
[Şule Merve Atalay] - Initial project ideation and early development support. 

## License
This project is licensed under the MIT License - see the LICENSE file for details.
