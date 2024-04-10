
import SwiftUI

struct CoffeeView: View {
    @State private var isContentVisible = false
    var body: some View {
        
        VStack (spacing: 10 ) {
            
            // App icon
            Image("coffeeIcon") // Replace "appIconName" with your app icon name
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            
            
                .padding()
            Text("Discover the best coffee spots in your area!")
                .font(.custom("Inter-Bold", size: 36))
                .multilineTextAlignment(.leading)
            
            
                .padding()
            NavigationLink(destination: SelectionView()) {
                Text("Explore Areas!")
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
        
    }
    
    
}
