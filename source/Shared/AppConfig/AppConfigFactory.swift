
import Foundation

public class AppConfigFactory {
    
    public lazy var defaultAppConfig: AppConfig = {
        let appConfig: AppConfig = environment(production: { return ProductionAppConfig() },
                                               development: { return DevAppConfig() })
        return appConfig
    }()
    
    public func appConfigFor(environment: AppConfigEnvironment) -> AppConfig {
        switch environment {
        case .production:
            return ProductionAppConfig()
        case .development:
            return DevAppConfig()
        }
    }
}
