import SwiftUI
import GoogleMaps

struct MapsView: View {
    private var mapsViewModel: MapsViewModel

    init() {
        self.mapsViewModel = MapsViewModel()
    }
    var body: some View {
        VStack {
            GoogleMapView()
                .environmentObject(mapsViewModel)
        }
        .onAppear {
            mapsViewModel.getLocation()
        }
    }
}
