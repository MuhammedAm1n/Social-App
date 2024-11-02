
# Social App

A Flutter-based social networking application that allows users to register, log in, create posts, send messages, and manage their profiles. The app utilizes Firebase for authentication, Firestore for data storage, and follows Clean Architecture principles to maintain a scalable and maintainable codebase.

## Features

- **User Registration**: Users can create an account using their email and password.
- **User Login**: Authenticate users securely with Firebase Authentication.
- **Profile Management**: Users can create and manage their profiles.
- **Post Creation**: Users can create and view posts in a real-time feed.
- **Messaging**: Users can send and receive messages with other users.
- **Stream Updates**: Utilize StreamBuilder to display real-time updates for posts and messages.

## Technologies Used

- **Flutter**: The framework for building the app.
- **Firebase**: Used for authentication, database (Firestore), and cloud functions.
- **Provider**: State management solution to manage the app's state effectively.
- **Clean Architecture**: Structure the project for better scalability and maintainability.

## Architecture

The project follows Clean Architecture principles, separating the concerns of presentation, domain, and data layers:

- **Presentation Layer**: Contains UI components and manages user interactions.
- **Domain Layer**: Defines the business logic and entities.
- **Data Layer**: Responsible for data sources (Firebase Firestore, authentication) and implementing the repository pattern.

