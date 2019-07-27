import Foundation
import Services

public protocol AuthorizedServiceLocator {
    
    var logOutService: LogOutService { get }
}
