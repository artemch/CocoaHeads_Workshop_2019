import Foundation

public protocol EntityModel {
    
    associatedtype IDValueType: Hashable
    
    var id: ID<IDValueType> { get }
}
