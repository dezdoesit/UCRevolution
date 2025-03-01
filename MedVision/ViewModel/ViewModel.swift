//
import Foundation

public class ClinicalViewModel: ObservableObject {
    @Published var trialslist: [Study] = []
    @Published var AISummary: String = ""
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
    func uploadDescription(description: String) async{
        Task
            {
            do{
                try await service.uploadDescription(description: description)
            }
            catch{
                print("error \(error)")
            }
        }
    }
    func fetchAISummary() {
        Task{
            service.fetchAISummary(){result in
                DispatchQueue.main.async {
                    self.AISummary = result
                }
            }
        }
    }
    
}
