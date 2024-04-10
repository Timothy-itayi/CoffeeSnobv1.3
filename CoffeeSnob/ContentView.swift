import SwiftUI

struct ContentView: View {
    @State private var isContentVisible = false

    var body: some View {

        NavigationView {
            VStack(spacing: 20) {
                // App icon
                ZStack {
                    Image("coffeeIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .opacity(isContentVisible ? 1 : 0) // Animate the opacity


                }

                // Title of the app
                Text("Welcome to CoffeeeSnob!")
                    .font(.custom("Inter-Bold", size: 36))

                    .multilineTextAlignment(.center)
                    .scaleEffect(isContentVisible ? 1 : 0.5) // Animate the scale


                NavigationLink(destination: CoffeeView()) {
                    Text("Lets Grab a Coffee!")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.yellow)
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
           // Animate the scale


        }
    }
}
