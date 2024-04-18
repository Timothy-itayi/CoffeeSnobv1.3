# CoffeeSnob

CoffeeSnob is a mobile app that helps you discover and explore the best cafes in your area using TomTomMapsSDK(IOS) . Whether you're looking for a cozy spot to work, catch up with friends, or simply enjoy a delicious cup of coffee, CoffeeSnob has got you covered. 

## Features

- **Discover Cafes**: Explore cafes in Melbourne and Hamitlon.
- **Interactive Map**: Visualize nearby cafes on an interactive map and easily navigate to your desired destination by tapping on the markers on the map.

## CoffeeSnob Prototype 


--This idea came about because my girlfriend who is a product designer had a prototype that she had created with her friends a few years ago when she was studying graphic design at university. The protoype came with all sorts of features , an Auth, being able to save your favourite cafes, being able to filter coffee based on preference i.e(long black, flat white etc).  

<img width="570" alt="Screenshot 2024-04-18 at 2 58 25 PM" src="https://github.com/Timothy-itayi/CoffeeSnobv1.3/assets/119027453/71ea7e14-37c1-428b-aecb-40b72c9e8f37">

<img width="570" alt="Screenshot 2024-04-18 at 2 58 25 PM" src="https://github.com/Timothy-itayi/CoffeeSnobv1.3/assets/119027453/f3eca8a2-af14-48c5-b879-c990912480c5">

--
-- I realised I wanted to try and create the app in the same fashion but change the design a little bit, mainly in regards to today's standard of design as the initial protoype design I found was outdated.  So I started brain storming how I could manage to incoporate the same design insofar as finding suitable libraries that could invoke the same overall feel of the application  using react-native with expo. The reason I chose to do this was because that was the only to create a mobile app with ios in mind. 

After a few days of configuring my environment to suit react-native and expos demands and about a week after that  I ended up with this design. I just hard coded everything to get an idea of how it was going to look with cafes in the feed/Home page. 




![IMG_5984](https://github.com/Timothy-itayi/CoffeeSnobv1.3/assets/119027453/8f773ab7-0f53-4c12-b71e-c80ae740bf9b)

--After a while though things got very difficult very quickly because as I was working I realised that I could not keep adding more features such as creating an auth for users or a database or anything more for that matter as it became apparent to me that this project would take weeks maybe months to come together since I was the only developer working on it. I had to scale it back tremendously and focus on the features that popped out the most and make that the focal point of the application. 

--After 2 weeks I went back to the drawing board and created a new project called CoffeeSnobv1.3 and decided to code in swift, I had never written in swift before so this was a whole new ball game. In saying that I tried to use googlesMapsSDK and thier authSDK (firebase) but that was imcompatible with what I wanted to achieve , mainly due to a feature of firebase being deprecated and also having to pay for and hopefully to acquire a apple developers program certificate(which i still have not recieved).

--In short I scaled back even further and decided to scrap google all together and find a third party service to provide the features I needed which led me to TomTom. These guys had a great package but again more hurdles insofar as to understand how the methods work with one another and having  prerequisite knowledge of swift to begin with made this very difficult. But I managed to push through.



   ![Simulator Screenshot - iPhone 15 Pro - 2024-04-16 at 16 39 57](https://github.com/Timothy-itayi/CoffeeSnobv1.3/assets/119027453/f4ad8310-3d7a-435b-9d41-24fb136730ae) 

   ![Simulator Screenshot - iPhone 15 Pro - 2024-04-16 at 16 40 14](https://github.com/Timothy-itayi/CoffeeSnobv1.3/assets/119027453/337d10e0-c313-48ed-8075-87d525703cd2)


## Getting Started

To get started with CoffeeSnob, follow these steps:

1. Clone this repository to your local machine.
2. Open the project in Xcode.
3. To use the App you need to sign up to TOmTomSDK(IOS) and acquire the apiKey in order to render the map
4. Build and run the app on your iOS device or simulator.

## Requirements

- Xcode 14.0 or later
- iOS 13.0 or later

## Dependencies

CoffeeSnob uses the following dependencies:

- [TomTomSDKMapDisplay](https://github.com/tomtom-international/tomtom-navigation-ios-examples): TomTom Maps SDK for displaying maps and integrating location-based services.
- [SwiftUI](https://www.swift.org/getting-started/swiftui/): SwiftUI framework for building user interfaces.


---

This README provides a brief overview of CoffeeSnob, its features, how to get started with the project, requirements, dependencies, contribution guidelines, and licensing information. You can customize it further to include more specific details about your project.

# COFFEESNOB
#### Video Demo:  <https://youtu.be/i3jE4w2PQig>
#### Description:
TODO:  Consume TomTomOnlineMaps to filter by Cafe in Hamilton , Display map and Interactive Markers when tapped to display cafe Cards
