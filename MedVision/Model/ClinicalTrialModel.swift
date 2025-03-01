import Foundation

struct ClinicalTrial: Codable {
    let studies: [Study]

}
struct Study: Codable {
    let protocolSection: ProtocolSection

}
struct ProtocolSection: Codable {
    let descriptionModule: DescriptionModule
    let eligibilityModule: EligibilityModule
    let contactsLocationsModule: ContactsLocationsModule
}

    


struct DescriptionModule: Codable {
    let briefSummary: String?
    let detailedDescription: String?
}

struct EligibilityModule: Codable {
    let eligibilityCriteria: String?
    let sex: String?
    let minimumAge: String?
    let maximumAge: String?
}

struct ContactsLocationsModule: Codable {
    let centralContacts: [CentralContact]?
}

struct CentralContact: Codable {
    let name: String?
    let phone: String?
    let email: String?
}
