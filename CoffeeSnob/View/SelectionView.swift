import SwiftUI

struct SelectionView: View {
    @State private var isContentVisible = false
    
    
let customColor = Color(red: 75.0/255.0, green: 50.0/255.0, blue: 30.0/255.0)
    var body: some View {
      

        VStack (spacing: 25 ) {
            
            // App icon
            Image("coffeeIcon") // Replace "appIconName" with your app icon name
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .opacity(isContentVisible ? 1 : 0) // Animate the opacity
            
            
            Text("Select a city")
                .font(.custom("Sling-Bold", size: 36))
                .scaleEffect(isContentVisible ? 1 : 0.5) // Animate the scale

             
            
            NavigationLink(destination: MelbourneMapView()) {
                Text("Melbourne")
                    .font(.custom("Inter-Bold", size: 18))

                    .padding()
                    .frame(maxWidth: 300)
                    .background(customColor) // Set button background color
                    .foregroundColor(.white) // Set button text color
                    .font(.headline) // Set button text font
                    .cornerRadius(10) // Add rounded corners
                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2) // Add shadow
                    .opacity(isContentVisible ? 1 : 0) // Animate the opacity

            }
            .padding(.horizontal) // Add horizontal padding
            
            NavigationLink(destination: RouteView()) {
                Text("Hamilton")
                    .font(.custom("Inter-Bold", size: 18))

                    .padding()
                    .frame(maxWidth: 300)
                    .background(customColor) // Set button background color
                    .foregroundColor(.white) // Set button text color
                    .font(.headline) // Set button text font
                    .cornerRadius(10) // Add rounded corners
                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2) // Add shadow
                    .opacity(isContentVisible ? 1 : 0) // Apply opacity based on visibility
            }
            .padding(.horizontal) // Add horizontal padding
            .onAppear {
                withAnimation {
                    self.isContentVisible = true // Animate the appearance of content
                    
                }
            }
            .onDisappear {
                self.isContentVisible = false // Reset the state when the view disappears
            }
            
        }
        .navigationBarTitle("") // Hide the default navigation title
    
        
    }
}
    

