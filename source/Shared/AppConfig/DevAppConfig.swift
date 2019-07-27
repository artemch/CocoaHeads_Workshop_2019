import Foundation

public class DevAppConfig: AppConfig {
    
    public let environment = AppConfigEnvironment.development
    
    public let host: String = ""
    
    public let securityStoreName = "dev.workshop_2019"
    
    public let storageName = "Dev.Workshop_2019"
    
    public let googleClientId = ""
    
    public let isFirstRun: Bool = DevAppConfig.internalCheckIfFirtsRun()
}
