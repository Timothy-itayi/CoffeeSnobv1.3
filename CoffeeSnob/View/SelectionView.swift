import SwiftUI

struct SelectionView: View {
    
    var body: some View {
        
        
        VStack (spacing: 20 ) {
            
            // App icon
            Image("coffeeIcon") // Replace "appIconName" with your app icon name
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .padding()
            
            Text("Select a city!")
                .font(.custom("Inter-Bold", size: 24))
                .padding()
            
            NavigationLink(destination: MelbourneMapView()) {
                Text("Melbourne")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black) // Set button background color
                    .foregroundColor(.yellow) // Set button text color
                    .font(.headline) // Set button text font
                    .cornerRadius(10) // Add rounded corners
                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2) // Add shadow
            }
            .padding(.horizontal) // Add horizontal padding
            
            NavigationLink(destination: RouteView()) {
                Text("Hamilton")
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
        .navigationBarTitle("") // Hide the default navigation title
    
        
    }
}
    

