//
//  TrialDetailView.swift
//  MedVision
//
//  Created by Christopher Woods on 3/1/25.
//

import SwiftUI

struct TrialDetailView: View {
    @EnvironmentObject var detailVM: DetailViewModel
    var body: some View {
        Text(detailVM.contactName)
    }
}

#Preview {
    TrialDetailView().environmentObject(DetailViewModel())
}
