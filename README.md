# Weather App

Build a simple app to hit the Open Weather Map API and show the weather based on zip code. Give the option to view the forecast for a week.

## Features
- Showing Current Weather details and forecast temperature for the next 5 days.


## Architecture
The app follows the MVVM architecture pattern and is fully developed in Swift.


## Testing
The app includes unit tests to ensure the correctness of its components and features. The tests can be run using Fastlane, which provides automation for building, testing, and deploying iOS apps. Fastlane actions can execute the unit tests and generate test reports.

### Prerequisites
Before running the unit tests using Fastlane, make sure you have the following:

- Xcode installed on your machine.
- Fastlane installed globally on your machine.

### Running Unit Tests with Fastlane
To run the unit tests and generate test reports using Fastlane, follow these steps:

1. Open a terminal and navigate to the root directory of the WhetherReport project.
2. Run the following command to execute the unit tests:

```
fastlane run_tests
```
This command will build the app, run the unit tests, and generate test reports.

<img width="1440" alt="Screenshot 2024-02-23 at 7 13 23 PM" src="https://github.com/DeepakMaheshwari05/WhetherReport/assets/16878448/850e885d-1b69-48e3-882b-59aaa16bd49a">


# Sonarqube
Here is the report generated from Sonarqube locally on the machine

<img width="1440" alt="Screenshot 2024-02-23 at 4 44 02 PM" src="https://github.com/DeepakMaheshwari05/WhetherReport/assets/16878448/5e4b0834-8c22-4dfa-be4a-845ebb7a0530">


## Environment
- Swift 5
- iOS 15+
- XCode 14.2

