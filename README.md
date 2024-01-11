# baby_milestones_tracker

The Milestone Tracker App is designed to help mothers add, view, and edit milestones for their babies. 
It provides a user-friendly interface for tracking important events such as a baby's first smile or first step.
The app utilizes Flutter for the frontend and implements state management to ensure data persistence between app sessions.

## Key Features

- **Onboarding Screen:** Welcomes users to the app and provides initial setup instructions.
- **Dashboard Screen:** Allows mothers to add, view, and edit milestones with details such as date, milestone type, and additional notes.
- **State Management:** Utilizes the Provider to manage the app's state and persist milestone data.

## App Structure

```plaintext
milestone_tracker/
|-- lib/
|   |-- core/
|   |-- features/
|   |-- root/
|   |  |-- model

|   |-- widgets/
|   |   |-- milestone_screen.dart
|   |   |-- onboarding_screen.dart
|   |   |-- dashboard_screen.dart
|   |-- routes.dart
|   |-- main.dart
|-- pubspec.yaml
|-- README.md
