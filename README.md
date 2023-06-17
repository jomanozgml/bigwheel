## BIGWHEEL GAME STATISTICS

### Introduction
>This web application generates a bar chart based on the previous spin results of the **BIGWHEEL** game played in a casino. It provides a visual representation; *bar chart* of the frequency distribution of the different spin outcomes, allowing users to analyze the data easily.

### TECH-STACK
```
USER INTERFACE: Flutter (with Dart)
BACKEND: Cloud FireStore
VERSION CONTROL: GitHub with CI/CD Implementation
```
### Web Application URLs
`Development ENV:` https://spinbigwheel.web.app/

`Production ENV :` https://mangalshova.com.np/

### Screenshot
![BIGWHEEL_APP](/assets/images/bigwheel_app.webp)

### Setup and Configuration
1. Clone the GitHub repository: https://github.com/jomanozgml/bigwheel
2. Install Flutter and Dart on your local development machine.
3. Configure the necessary Firebase project and obtain the Firebase configuration.
4. Update the Firebase configuration in the Flutter project to connect to your Cloud Firestore instance. Create `secret.dart` file inside `lib\` folder containing API information from FireStore in following format:
```
class Secrets{
  Map<String, String> secretsMap = {
    // Dev env API
    'apiKey': 'paste api here',
    'authDomain': 'paste auth domain here',
    ... likewise

    //Prod env API
    ... same as above
  };
}
```
5. Build and run the Flutter application locally by running **main.dart** file
6. Deploy to created Firebase project
7. Set up CI/CD using GitHub Actions or any other preferred CI/CD tool to automate the deployment process to the production environment.

### Usage
- Access the web application using the provided URLs for the development or production environment.
- The web application will display the bar chart representing the frequency distribution of spin outcomes.
- Analyze the bar chart to gain insights into the previous spin results of the BIGWHEEL game.

### License
>The source code for this web application is licensed under the MIT License. You can find the license details in the LICENSE file in the GitHub repository.

### Contact
>If you have any questions or inquiries regarding this web application, please feel free to contact the developer at manoj.shrestha8080@gmail.com