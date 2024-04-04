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
                Text("Coffee Snob")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                    .padding()
                
                
                
                NavigationLink(destination: RouteView())  {
                    // Handle submission of text here
         
                    Text("Start the Snobbery")
                    
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue) // Set button background color
                        .foregroundColor(.white) // Set button text color
                        .font(.headline) // Set button text font
                        .cornerRadius(10) // Add rounded corners
                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2) // Add shadow
                }
                .padding(.horizontal) // Add horizontal padding
                
                .padding()
            }
            .padding()
            .navigationBarTitle("") // Hide the default navigation title
        }
    }
}
