# SugaryBliss: Desserts Recipe App
Welcome to SugaryBliss! This iOS application is built using SwiftUI and provides a user-friendly 
interface for browsing recipes fetched from an API. It allows you to view a list of recipes with 
their corresponding images, and upon selecting a recipe, you can access a detailed page 
containing a video, ingredients, and instructions.

## Features
* **SwiftUI**: SugaryBliss utilizes SwiftUI for creating an intuitive and visually appealing user interface.
* **Network Layer**: The app includes a dedicated network layer responsible for handling API requests and responses. 
This ensures efficient communication with the backend server.
* **Codable**: The project utilizes Codable, Swift's built-in protocol, to efficiently parse JSON data from the 
API response. The decoding process includes transforming ingredients into a list for easy access and manipulation.
* **Image Caching**: SugaryBliss implements image caching to optimize the performance and user experience. Images fetched 
from the API are stored in a cache, ensuring faster loading times and reducing data usage.
* **UIViewRepresentable** for WebKit: This allows you to embed and play YouTube videos directly within the app's user interface.

## Walkthrough
https://github.com/cesarlopezt/SugaryBliss/assets/4370350/7e105d47-7817-477b-89de-f287435b7fba


## Usage
To use the Recipe App on your iOS device or simulator, follow the instructions below:

1. Clone the repository from GitHub
2. Open the project in Xcode
3. Build and run the app on your selected iOS device or simulator.
4. Once the app is launched, you will be presented with a list of recipes fetched from the API. Scroll through the list to explore the available options.
5. To view more details about a recipe, tap on it. This will take you to a dedicated page containing a video player, a list of ingredients, and step-by-step instructions.

Enjoy exploring and cooking delicious recipes with SugaryBliss!

## Requirements
The Recipe App has the following requirements:
* iOS 15.0+
