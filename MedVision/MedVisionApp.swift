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
    @ObservedObject var Trial = ClinicalViewModel()
    @StateObject var DetailVM = DetailViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(Trial: Trial)
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
            TrialDetailView(Trial: Trial).environmentObject(DetailVM)
        }
    }
}
