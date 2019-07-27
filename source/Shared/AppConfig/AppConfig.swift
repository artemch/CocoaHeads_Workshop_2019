import Foundation

public enum AppConfigEnvironment {
    case production
    case development
}

public protocol AppConfig {
    
    var environment: AppConfigEnvironment { get }
    
    var host: String { get }
    
    var securityStoreName: String { get }
    
    var storageName: String { get }
    
    var googleClientId: String { get }
    
    var isFirstRun: Bool { get }
}

extension AppConfig {
    static func internalCheckIfFirtsRun() -> Bool {
        let userDefaults = UserDefaults.standard
        let key = "isFirstRun"
        let isFirstRun = userDefaults.value(forKey: key).flatMap { $0 as? Bool } ?? true
        userDefaults.set(false, forKey: key)
        return isFirstRun
    }
}
