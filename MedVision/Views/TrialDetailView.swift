//
//  TrialDetailView.swift
//  MedVision
//
//  Created by Christopher Woods on 3/1/25.
//

import SwiftUI

struct TrialDetailView: View {
    @EnvironmentObject var detailVM: DetailViewModel
    @ObservedObject var Trial: ClinicalViewModel
    @State var loading: Bool = false
    var body: some View {
        Text(detailVM.description)
        Text(detailVM.contactName)
        Text(detailVM.phoneNumber)
        Text(detailVM.email)
        
        Button(action: {
            loading = true
            Task{
                print("uploading Description")
                await Trial.uploadDescription(description: detailVM.description)
                print("getting ai")
                Trial.fetchAISummary()
            }
            loading = false
        }, label: {
            Text("AI Summarize")
        }).disabled(loading)
        
        
        Text(Trial.AISummary)
    }
    
}

#Preview {
    TrialDetailView(Trial: ClinicalViewModel()).environmentObject(DetailViewModel())
}
