import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @Environment(\.openWindow) private var openWindow
    @ObservedObject var Trial = ClinicalViewModel()
    @EnvironmentObject var detailVM: DetailViewModel

    // Define the grid layout
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(Trial.trialslist, id: \.self.protocolSection.identificationModule.nctId) { trial in
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue)
                            .overlay(
                                Text("T")
                                    .foregroundColor(.white)
                                    .font(.caption)
                            )
                            .padding()
                            .onTapGesture {
                                detailVM.contactName = trial.protocolSection.contactsLocationsModule.centralContacts[0].first!
                                openWindow(id: "DetailView")
                            }
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 50)
            }
            Button(action: {detailVM.contactName = "John"}, label: {Text("EDIT VM")})
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
