//
import Foundation

public class ClinicalViewModel: ObservableObject {
    @Published var trialslist: [Study] = []
    private let service = ClinicalDataService()
    
    init() {
        fetchStudies()
    }
    
    func fetchStudies() {
        service.fetchClinicalTrials(){result in
            DispatchQueue.main.async {
                self.trialslist = result
                }
            }
        }
    
}
