# CivicAlert

CivicAlert is a mobile app built with Flutter that empowers users to report and upvote complaints about local issues. If a complaint reaches five or more upvotes, it is automatically forwarded to the appropriate government authorities, increasing the likelihood of action on community concerns. By leveraging Appwrite for backend services and a Python script for automated email notifications, CivicAlert ensures that community voices are amplified effectively.

## Features

1. User-Generated Complaints: Users can submit complaints with relevant details (title, description, location, images).
2. Community Feed: Complaints are displayed in a feed view, ordered by upvotes, allowing users to support issues they care about.
3. Automated Government Notification: A Python script, deployed on a server, continuously monitors the Appwrite database for changes in upvotes. When a complaint reaches five upvotes, it triggers an automated email notification to the government, ensuring timely awareness of popular community concerns.
4. Personal Complaint Management: Users can track and view complaints they’ve submitted, monitoring issue progress and public support.

## Architecture

CivicAlert uses the Model-View-Controller (MVC) architecture to maintain clean and

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
   - Create a new Appwrite collection called "complaints" with the following required attributes:
     - `title` (string)
     - `description` (string)
     - `location` (string)
     - `contactNumber` (string)
     - `imageLinks` (Array of string)
     - `uid` (string)
     - `complainedAt` (int)
     - `upvotes` (Array of string)
     - `downvotes` (Array of string)
     - `commentIds` (Array of string)
     - `reshareCount` (int)
     - `currentLocation` (string)
   - Create a new Appwrite storage bucket called "images".
   - Update the `AppwriteConstants` class in your project with the correct Appwrite project and endpoint information:

     ```dart
     class AppwriteConstants {
       static const String databaseId = 'YOUR_APPWRITE_DATABASE_ID';
       static const String projectId = 'YOUR_APPWRITE_PROJECT_ID';
       static const String endPoint = 'YOUR_APPWRITE_ENDPOINT';

       static const String userCollections = 'YOUR_USERS_COLLECTION_ID';
       static const String complainCollections = 'YOUR_COMPLAINTS_COLLECTION_ID';

       static const String imagesBucket = 'YOUR_IMAGES_BUCKET_ID';
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
