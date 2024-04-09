import SwiftUI

struct ContentView: View {
    @State private var text: String = ""
    
    var body: some View {
        
        NavigationView { // Embed ContentView in a NavigationView
            VStack (spacing: 20 ){
                
                // App icon
                Image("coffeeIcon") // Replace "appIconName" with your app icon name
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                
                
                // Title of the app
                Text("Welcome to CoffeeeSnob!")
                    .font(.custom("Inter-Bold", size: 36))
                    .padding()
                
                
                
                NavigationLink(destination: CoffeeView())  {
                    // Handle submission of text here
                    
                    Text("Lets Grab a Coffee!")
                    
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black) // Set button background color
                        .foregroundColor(.yellow) // Set button text color
                        .font(.headline) // Set button text font
                        .cornerRadius(10) // Add rounded corners
                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2) // Add shadow
                }
                .padding(.horizontal) // Add horizontal padding
             
                }
                .padding()
                .navigationBarTitle("") // Hide the default navigation title
            }
        }
    }

