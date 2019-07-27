import Foundation

public struct ProfileViewData {
    public let onLogOut: (() -> ())?
    
    static public var initial: ProfileViewData {
        return ProfileViewData(onLogOut: nil)
    }
}
