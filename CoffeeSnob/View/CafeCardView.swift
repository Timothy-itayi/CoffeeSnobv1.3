import SwiftUI

struct CafeView: View {
    var body: some View {
        VStack {
            Text("Welcome to the Cafe Map!")
                .font(.title)
                .padding()
        
                .edgesIgnoringSafeArea(.all)
                .frame(height: 300)
        }
    }
}
