
import SwiftUI

struct MelbourneMapView: View {
    var body: some View {
        MelbourneViewControllerRepresentable()
    }
}


struct MelbourneViewControllerRepresentable:
    UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some MelbourneMapViewController {
         return MelbourneMapViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
