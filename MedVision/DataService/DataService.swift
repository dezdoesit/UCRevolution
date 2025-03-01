


import Foundation

public class ClinicalDataService{
    let AIString = "https://ancient-math-56cb.shirtlesspenguin.workers.dev"
        
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
    func fetchAISummary(completion: @escaping (String) -> Void){
        guard let url = URL(string: "\(AIString)/") else { return }
        
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
                let response  = try JSONDecoder().decode([AIResponse].self, from: data)
                let results = response[0].response
                completion(results)
            } catch {
                print("Error decoding data: \(error)")
            }
            
            
        }.resume()
    }
    func uploadDescription(description: String) async throws {
            guard let url = URL(string: "\(AIString)/description") else {
                throw URLError(.badURL)
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("text/plain", forHTTPHeaderField: "Content-Type")
            request.httpBody = description.data(using: .utf8)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }
            
            // Optional: Parse response if needed
            if let responseString = String(data: data, encoding: .utf8) {
                print("Upload Response: \(responseString)")
            }
        }
}
