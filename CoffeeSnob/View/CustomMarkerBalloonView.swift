import SwiftUI


struct CustomMarkerBalloonView: View {
    var cafeCard: String

    var body: some View {
        VStack(alignment: .center) {
            Image( systemName: "coffeemarker" )
                .font(.system(size: 100))
            Text(cafeCard)
                .onAppear() {
                    print("Cafe Card: \(cafeCard)")
                }
        }
        .padding()
    }
}
