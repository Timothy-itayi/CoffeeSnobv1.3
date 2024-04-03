import SwiftUI

struct CustomMarkerBalloonView: View {
    var locationCoordinates: String

    var body: some View {
        VStack(alignment: .center) {
            Text(locationCoordinates)
                       .padding()
                       .background(Color.white) // Set background color
                       .cornerRadius(8) // Apply corner radius
                       .shadow(radius: 3) // Apply shadow
                       .multilineTextAlignment(.center) // Align text in the center
                       .foregroundColor(.black) // Set text color
                       .font(.body) // Set font size
        }
        .padding()
    }
}
