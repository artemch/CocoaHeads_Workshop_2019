import Foundation
import Services

public class AuthorizedServiceLocatorImp: AuthorizedServiceLocator {
    
    private let appServiceLocator: AppServiceLocator
    
    private let factoryLocator: FactoryLocator
    
    // MARK: - Initializations and Deallocations
    
    init(appServiceLocator: AppServiceLocator,
         factoryLocator: FactoryLocator)
    {
        self.appServiceLocator = appServiceLocator
        self.factoryLocator = factoryLocator
    }
    
    // MARK: - Public methods
    
    lazy public var logOutService: LogOutService = { [unowned self] in
        let factoryLocator = self.factoryLocator
        let googleSignInProvider = self.appServiceLocator.googleSignInProvider
        let logOutClosure = { googleSignInProvider.signOut() }
        return factoryLocator.servicesFactory.logOutService(logOutBackendService: factoryLocator.backendServiceFactory.logOut(),
                                                                 logOutStorage: factoryLocator.storageFactory.logOutStorage(),
                                                                 securityService: self.appServiceLocator.securityService,
                                                                 socialServiceLogOutProvider: SocialServiceLogOutProviderImp(logOutClosure: logOutClosure))
    }()
}
