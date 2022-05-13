
import Foundation

final class UserDefaultsLocal{
    enum forKeys{
        static let remitCountry = "RemitCountry"
        static let receiptCountry = "ReceiptCountry"
    }
    static let shared = UserDefaultsLocal()
    
    private let preferences = UserDefaults.standard
    
    private init() {}
    
    var remitCountry: Country{
        get {
            Country(rawValue: preferences.string(forKey: forKeys.remitCountry) ?? "") ?? .usd
        }
        set {
            preferences.set(newValue.rawValue, forKey: forKeys.remitCountry)
        }
    }
    var receiptCountry: Country{
        get {
            Country(rawValue: preferences.string(forKey: forKeys.receiptCountry) ?? "") ?? .krw
        }
        set {
            preferences.set(newValue.rawValue, forKey: forKeys.receiptCountry)
        }
    }
}
