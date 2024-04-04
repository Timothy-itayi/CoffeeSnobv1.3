
import SwiftUI

struct RouteView: View {
    var body: some View {
        RouteViewControllerRepresentable()
    }
}


struct RouteViewControllerRepresentable:
    UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some RouteViewController {
         return RouteViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
