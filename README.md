# CoffeeSnob

CoffeeSnob is a mobile app that helps you discover and explore the best cafes in your area using TomTomMapsSDK(IOS) . Whether you're looking for a cozy spot to work, catch up with friends, or simply enjoy a delicious cup of coffee, CoffeeSnob has got you covered. 

## Features

- **Discover Cafes**: Explore cafes in Melbourne and Hamitlon.
- **Interactive Map**: Visualize nearby cafes on an interactive map and easily navigate to your desired destination by tapping on the markers on the map.

## CoffeeSnob Prototype 


--This idea came about because my girlfriend who is a product designer had a prototype that she had created with her friends a few years ago when she was studying graphic design at university. The protoype came with all sorts of features , an Auth, being able to save your favourite cafes, being able to filter coffee based on preference i.e(long black, flat white etc), being able to route the user to the destination of the cafe and lead them there as well as notify the user if there were other cafes in the area along the way.

--It's important to note that when my girlfriend had informed me of the initial idea I warned her that I would need to scale back the application. Due to the fact that this was my first time working with a designer and making a mobile application to begin with .I had to let her know that what she had proposed had to be scaled back tremendously. Instead I ended up focusing on the front-end portion of the application focusing on the display and user experience. How would you feel using this application? I started there. 
<div style="pointer-events: none;">
  <img width="534" alt="Screenshot 2024-04-18 at 3 51 38 PM" src="https://github.com/Timothy-itayi/CoffeeSnobv1.3/assets/119027453/2d09a77f-5899-448f-92c8-017fbd75c1ae">
 
</div>

<div style="pointer-events: none;">
  <img width="570" alt="Screenshot 2024-04-18 at 2 58 25 PM" src="https://github.com/Timothy-itayi/CoffeeSnobv1.3/assets/119027453/f3eca8a2-af14-48c5-b879-c990912480c5">
 
</div>

--
-- I realised I wanted to try and create the app in the same fashion but change the design a little bit, mainly in regards to today's standard of design as the initial protoype design I found was outdated to me.  So I started brain storming how I could manage to incoporate the same design insofar as finding suitable libraries that could invoke the same overall feel of the application  using react-native with expo. The reason I chose to do this was because that was the only way to create a mobile app with ios in mind.  

After a few days of setting up my dependencies to suit react-native and expos demands and about a week after that  I ended up with this design. Though I will add I found out quite quickly that I ended up having to code all the front-end components from scratch as there weren't any suitalbe libraries that could match the tone I was going for. 

Here is a link to the github for my react-native with expo version written in javascript: (https://github.com/Timothy-itayi/Coffee-Snob)

When I created the first iteration of the app I had to create  cafe data and store it locally and then pass the data through as props. This was a standard approach when working with react so I found it quite easy to work with. 



<div style="pointer-events: none;">
   ![reactNativeCoffee](https://github.com/Timothy-itayi/CoffeeSnobv1.3/assets/119027453/ff26e029-5fbe-4f6d-9dc0-697742441c6c)
</div>


--After a while though things got very difficult very quickly because as I was working I realised that I could not keep adding more features such as creating an auth for users or a database or anything more for that matter as it became apparent to me that this project would take weeks maybe months to come together since I was the only developer working on it. I had to scale it back tremendously and focus on the features that popped out the most and make that the focal point of the application. 

--After 2 weeks I went back to the drawing board and created a new project called CoffeeSnobv1.3 and decided to code in swift, I had never written in swift before so this was a whole new ball game. In saying that I tried to use googlesMapsSDK and thier authSDK (firebase) but that was imcompatible with what I wanted to achieve , mainly due to a feature of firebase being deprecated and also having to pay for and hopefully acquire a apple developers program certificate(which I have yet to recieve ).




--In short I scaled back even further and decided to scrap google all together and find a third party service to provide the features I needed which led me to TomTom. These guys had a great package but again more hurdles insofar as to understand how the methods work with one another and having  prerequisite knowledge of swift to begin with made this very difficult. But I managed to push through.

--The reason I chose TomTom to start of with was because I felt like the inital prototpye idea of having a map that allows the user to route was interesting to me. 

--However I realised I could not just make a 1:1 replica of the protoype, so I went back and took a look at the route feature of the map protoype and decided to just have a map display with markers so that the user only taps on markers in their area. I didnt want ot get involved with a real time location set up when using or demoing the app so I decided to set up inital coordinates for the map to render into. In my case I chose Hamilton/New Zealand. 


--The reason I chose to do it this way  was because I had already taken weeks making the first version of coffeesnob and so I placed a time frame on this version which was  2 Weeks .. 

--Week 1: Familiarize myself with swift and xcode /Familiarise myself with TomTom Methods &  set up TomTomSDK/ initalise the map / set up functions/ collect cafe data / display cafe data 

--Week 2 : create cafe cards in swiftUI / format files / format code / write comments 

--As you can imagine there was a lot to do with very little time but I managed to push forward with the project. 
--I did however want to write test for the project to see if the functions were working as expected plus it is nice to write tests, though that never materialised due to xcode having build errors. I tried to solve those errors but It became clear that I would end up having to break the app further in order to try and fix it. 
<div style="pointer-events: none;">
   <img width="616" alt="Screenshot 2024-04-17 at 5 44 21 PM" src="https://github.com/Timothy-itayi/CoffeeSnobv1.3/assets/119027453/633a7abd-ecbb-42f4-8847-c02a248616ed">
</div>

-- So let me give you a run down of the files I chose to make in my project.
--For starters I created a RouteView controller to display the map as well utilise the TomTomsSDK methods such as the onMapDisplay and AddMarkers function.

<div style="pointer-events: none;">
   [MapDisplay](https://github.com/Timothy-itayi/CoffeeSnobv1.3/blob/main/CoffeeSnob/Controller%20/New%20Zealand/RouteViewController.swift)
</div>


-- Then once I was able to display the map and the coordinates I went on to create the cafe Data . I knew it would be best to follow the common practice and create a seperate file to hold the data and then import that file when needed into the mapView.


   [Cafe-Manager](https://github.com/Timothy-itayi/CoffeeSnobv1.3/blob/main/CoffeeSnob/Models/New%20Zealand/CafeManager.swift)




-- Next I needed to incoporate the interaciton method  made by TomTom in order to make the mapDisplay functional. TomTom uses a method called OnInteraction. This method comes with a delegate you must place on the class of your choice in order for it to link to the map display , Inside of that delegate came the method OnInteraciton which came with an array of switch case functions you could choose from ... so I wrote a function that if a marker is tapped it would trigger a bottom sheet to appear displaying the cafe card. 


   [onInteraction](https://github.com/Timothy-itayi/CoffeeSnobv1.3/blob/main/CoffeeSnob/Models/New%20Zealand/InteractionManager.swift)


-- I then had to create a CafeCardController in order to display the cafe details, this CafeCardController would be triggered by the onInteraction delegate functions when a user tapped on the markers on the map 


   [CafeCardController](https://github.com/Timothy-itayi/CoffeeSnobv1.3/blob/main/CoffeeSnob/Controller%20/New%20Zealand/CafeViewController.swift)


--After that all I needed to do was customise the cards and the app as a whole and repeat the process for adding other locations. 


--Anyway I hope you had fun reading my journey as much I did experiencing it.
<div style="pointer-events: none;">
      ![Simulator Screenshot - iPhone 15 Pro - 2024-04-16 at 16 39 57](https://github.com/Timothy-itayi/CoffeeSnobv1.3/assets/119027453/f4ad8310-3d7a-435b-9d41-24fb136730ae) 
      ![Simulator Screenshot - iPhone 15 Pro - 2024-04-16 at 16 40 14](https://github.com/Timothy-itayi/CoffeeSnobv1.3/assets/119027453/337d10e0-c313-48ed-8075-87d525703cd2)
</div>


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
