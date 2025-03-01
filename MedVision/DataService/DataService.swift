


import Foundation

public class ClinicalDataService{
    let urlString = "https://clinicaltrials.gov/api/v2/studies?query.term=virtual%2Cremote&filter.overallStatus=RECRUITING&filter.geo=distance%2839.103119%2C-84.512016%2C500mi%29"
    
    
//    let urlString = "https://clinicaltrials.gov/api/v2/studies/NCT00587795"
    
    
    func fetchClinicalTrials(completion: @escaping ([Study]) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error {
                print("error: \(error)" )
                return
            }
            guard let data = data else {
                print("no data recevied")
                return
            }
            do {
                let response  = try JSONDecoder().decode(ClinicalTrial.self, from: data)
                let result = response.studies
                completion(result)
            } catch {
                print("Error decoding data: \(error)")
            }
            
            
        }.resume()
    }
}
