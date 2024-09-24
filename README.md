# CivicAlert

CivicAlert is a mobile app that allows users to submit and upvote complaints, which are then sent to the government if they receive more than 5 upvotes.

## Features

- Users can create and submit complaints with a title and description.
- Complaints are displayed in a community feed, sorted by the number of upvotes.
- Users can upvote complaints they agree with.
- Complaints with more than 5 upvotes are automatically sent to the government.
- Users can view a list of their own submitted complaints.

## File Structure

```
CivicAlert/
├── android/
├── ios/
├── lib/
│   ├── apis/
│   ├── common/
│   ├── constants/
│   ├── core/
│   ├── features/
│   ├── models/
│   ├── theme/
│   ├── main.dart
│   
├── test/
├── pubspec.yaml
└── README.md
```

## Getting Started

### Prerequisites

- Flutter SDK installed
- Appwrite account and project set up

### Installation

1. Clone the repository:

```
git clone https://github.com/chaitanyak175/CivicAlert.git
```

2. Navigate to the project directory:

```
cd CivicAlert
```

3. Install dependencies:

```
flutter pub get
```

4. Configure Appwrite:
   - Create an Appwrite project and note the project ID.
   - Create a new Appwrite Database with the name of your choice.
   - Create a new Appwrite collection called "users" with the following required attributes:
     - `email` (string)
     - `name` (string)
     - `address` (string)
     - `profilePic` (string)
     - `mobileNo` (string)
     - `isVerified` (boolean)
   - Update the `AppwriteConstants` class in your project with the correct Appwrite project and endpoint information:

     ```dart
     class AppwriteConstants {
       static const String databaseId = 'YOUR_APPWRITE_DATABASE_ID';
       static const String projectId = 'YOUR_APPWRITE_PROJECT_ID';
       static const String endPoint = 'YOUR_APPWRITE_ENDPOINT';

       static const String userCollections = 'YOUR_APPWRITE_COLLECTION_ID';
     }
     ```

5. Run the app:

```
flutter run
```

## Usage

1. Open the app and navigate to the "Create Complaint" screen.
2. Fill out the form with a title and description for your complaint.
3. Submit the complaint.
4. The complaint will now be visible in the community feed, sorted by the number of upvotes.
5. Other users can upvote the complaint by clicking the upvote button.
6. If a complaint receives more than 5 upvotes, it will be automatically sent to the government.
7. Users can view their own submitted complaints in the "My Complaints" screen.

## Contributing

If you would like to contribute to the CivicAlert project, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and test them thoroughly.
4. Submit a pull request, explaining the changes you've made and why.

## License

This project is licensed under the [MIT License](LICENSE).
