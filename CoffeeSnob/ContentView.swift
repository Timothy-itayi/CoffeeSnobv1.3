import SwiftUI

struct ContentView: View {
    @State public var isContentVisible = false
    let customColor = Color(red: 75.0/255.0, green: 50.0/255.0, blue: 30.0/255.0)

    var body: some View {

        NavigationView {
         
            VStack(spacing: 25) {
                // App icon
                ZStack {
                    
                    Image("coffeeIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .opacity(isContentVisible ? 1 : 0) // Animate the opacity
                    

                }

                // Title of the app
                Text("Welcome to CoffeeSnob")
                    .font(.custom("Sling-Bold", size: 36))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .scaleEffect(isContentVisible ? 1 : 0.5) // Animate the scale


                NavigationLink(destination: CoffeeView()) {
                    Text("Lets Go")
                        .font(.custom("Inter-Bold", size: 18))

                        .padding()
                        .frame(maxWidth: 300)
                        .background(customColor)
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)
                        .opacity(isContentVisible ? 1 : 0) // Apply opacity based on visibility
                }

            }
            .padding()
            .onAppear {
                withAnimation {
                    self.isContentVisible = true // Animate the appearance of content
                    
                }
            }
            .onDisappear {
                self.isContentVisible = false // Reset the state when the view disappears
            }
            .navigationBarTitle("")
             // Change the background color
        

        }
       
    }
}
