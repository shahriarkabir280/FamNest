# FamNest - A family finance and organizing android app
 
 <p>FamNest is a comprehensive app built to help families track expenses, store important documents, manage events, and preserve memories in a digital time capsule. It provides a secure, organized, and collaborative platform for family management.</p>


## Features 

- **Expense Tracking:** Log daily expenses for all family members.  
- **Budget Management:** Set monthly or weekly budgets for different categories.  
- **Shared Calendar:** Keep track of family events, birthdays, and appointments.  
- **Reports & Analytics:** Visualize spending patterns with charts and summaries.  
- **Multi-User Support:** Family members can use a shared account with personalized access.  
- **Secure & Private:** Data is stored securely, with optional cloud backup.  
- **Document Storage:** Safely store and organize important family documents like medical records, property papers, education certificates, financial documents, and more. Supports multiple folders and all types of files including images, videos, and text documents.  
- **Family Stories & Memories:** Preserve special moments, stories, and memories for future generations in a secure, organized way.

## Tech Stack 

- **Platform:** Android (built with Android Studio and Flutter)  
- **Language:** Dart (Flutter)  
- **Database:** MongoDB Atlas  
- **UI Framework:** Flutter Widgets  
- **File & Media Storage:** Cloudinary (for documents, images, videos, and other media)   
- **Development Environment:** Android Studio


---

## Installation 

Follow these steps to run FamNest on your local machine or Android device:

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/FamNest.git

```
### 2. Open the Project

- Open Android Studio.(if needed install Android studio - https://developer.android.com/studio)
- Click File > Open, then select the cloned repository folder.

### 3. Setup Flutter

- Make sure Flutter is installed: https://docs.flutter.dev/get-started/install
  - For Linux (Ubuntu) : https://youtu.be/mtqTnGAAHw0?si=ybBPNPOr2CBJc0LC
- Run the following command in the terminal to fetch all dependencies:
  
```bash
flutter pub get
```
### 4. Configure Database

- MongoDB Atlas: Create a cluster and get your connection URI.
- Update the app’s database configuration file with your MongoDB URI.( in FastAPI Backened )

### 5. Configure Cloudinary (for document/media storage)

- Sign up for a Cloudinary account.
- Get your Cloud name, API Key, and API Secret.
- Add them to the app’s configuration file or environment variables.

### 6. Run the App

- Connect an Android device or start an emulator.
- Click Run > Run 'app' in Android Studio or use:
```bash
flutter run
```
### 7. (Optional) Build APK

```bash
flutter build apk --release
```
This generates an installable .apk file in build/app/outputs/flutter-apk/.

## Usage 

- Register a family account or login.
- Add family members to the account.
- Start tracking expenses, creating events, and setting budgets.
- Upload and organize family documents in different categories.
- Record and store family stories or special moments.
- Use reports to analyze family finances.

## Contributing 

- Contributions are welcome! To contribute:
- Fork the repository.
- Create a new branch: git checkout -b feature/your-feature-name
- Make your changes and commit them: git commit -m 'Add some feature'
- Push to the branch: git push origin feature/your-feature-name
- Open a Pull Request.

## License 

This project is licensed under the MIT License. See the LICENSE file for details.

## Contact 

Name: Md. Shahriar Kabir

GitHub: https://github.com/shahriarkabir280

Email: shahriarkabir280@gmail.com

## Acknowledgements 

- Android Developers Documentation
- Flutter Documentation
- MongoDB Documentation
- Cloudinary Documentation
- Open-source libraries used in the project
