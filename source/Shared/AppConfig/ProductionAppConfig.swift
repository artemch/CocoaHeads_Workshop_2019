import Foundation

public class ProductionAppConfig: AppConfig {
    
    public let environment = AppConfigEnvironment.production
    
    public let host: String = ""
    
    public let securityStoreName = "workshop_2019"
    
    public let storageName = "Workshop_2019"
    
    public let googleClientId = ""
    
    public let isFirstRun: Bool = ProductionAppConfig.internalCheckIfFirtsRun()
    
}
