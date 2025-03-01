//
//  MedVisionApp.swift
//  MedVision
//
//  Created by Dezmond Blair on 3/1/25.
//

import SwiftUI

@main
struct MedVisionApp: App {
    @State private var appModel = AppModel()
    @StateObject var DetailVM = DetailViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appModel)
                .environmentObject(DetailVM)
        }

        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.full), in: .full)
        
        WindowGroup(id: "DetailView"){
            TrialDetailView().environmentObject(DetailVM)
        }
    }
}
