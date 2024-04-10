
import SwiftUI

struct CoffeeView: View {
    @State private var isContentVisible = false
    var body: some View {
       
            VStack (spacing: 20 ) {
                
                // App icon
                Image("coffeeIcon") // Replace "appIconName" with your app icon name
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .opacity(isContentVisible ? 1 : 0) // Animate the opacity
                
                
                    .padding()
                Text("Discover the best coffee spots in your area!")
                    .font(.custom("Inter-Bold", size: 24))
                    .scaleEffect(isContentVisible ? 1 : 0.5) // Animate the scale

                
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
                        .opacity(isContentVisible ? 1 : 0) // Apply opacity based on visibility
                }
                .padding(.horizontal) // Add horizontal padding
            }
            .onAppear {
                withAnimation() {
                    self.isContentVisible = true // Animate the appearance of content
                }
            }
            .onDisappear {
                self.isContentVisible = false // Reset the state when the view disappears
            }
        }
        
    
    
}
